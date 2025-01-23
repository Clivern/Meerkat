# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule ScutiWeb.ProfileController do
  @moduledoc """
  Profile Controller
  """

  use ScutiWeb, :controller

  require Logger

  alias Scuti.Module.UserModule
  alias Scuti.Service.ValidatorService
  alias Scuti.Service.AuthService

  @name_min_length 2
  @name_max_length 60

  plug :regular_user when action in [:update, :fetch_api_key, :rotate_api_key]

  defp regular_user(conn, _opts) do
    Logger.info("Validate user permissions")

    if not conn.assigns[:is_logged] do
      Logger.info("User doesn't have the right access permissions")

      conn
      |> put_status(:forbidden)
      |> render("error.json", %{message: "Forbidden Access"})
      |> halt
    else
      Logger.info("User has the right access permissions")

      conn
    end
  end

  @doc """
  Update Profile Endpoint
  """
  def update(conn, params) do
    case validate_update_request(params, conn.assigns[:user_uuid]) do
      {:ok, _} ->
        result =
          UserModule.update_user(%{
            uuid: conn.assigns[:user_uuid],
            email: params["email"],
            name: params["name"],
            password: params["password"]
          })

        case result do
          {:not_found, _} ->
            conn
            |> put_status(:bad_request)
            |> render("error.json", %{message: "Invalid Request"})

          {:ok, _} ->
            conn
            |> put_status(:ok)
            |> render("success.json", %{message: "Profile updated successfully"})

          {:error, msg} ->
            conn
            |> put_status(:bad_request)
            |> render("error.json", %{message: msg})
        end

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: reason})
    end
  end

  @doc """
  Fetch API Key Endpoint
  """
  def fetch_api_key(conn, _params) do
    case UserModule.get_user_by_uuid(conn.assigns[:user_uuid]) do
      {:not_found, msg} ->
        Logger.info(msg)

        conn
        |> put_status(:not_found)
        |> render("error.json", %{message: "Profile not found"})

      {:ok, user} ->
        conn
        |> put_status(:ok)
        |> render("user.json", %{api_key: user.api_key})
    end
  end

  @doc """
  Rotate API Key Endpoint
  """
  def rotate_api_key(conn, _params) do
    api_key = AuthService.get_uuid()

    case UserModule.rotate_api_key(conn.assigns[:user_uuid], api_key) do
      {:not_found, msg} ->
        Logger.info(msg)

        conn
        |> put_status(:not_found)
        |> render("error.json", %{message: "Profile not found"})

      {:error, msg} ->
        Logger.error(msg)

        conn
        |> put_status(:bad_request)
        |> render("error.json", %{message: "Failed to rotate the API Key"})

      {:ok, _} ->
        conn
        |> put_status(:ok)
        |> render("user.json", %{api_key: api_key})
    end
  end

  defp validate_update_request(params, user_uuid) do
    errs = %{
      name_required: "User name is required",
      name_invalid: "User name is invalid",
      email_required: "User email is required",
      email_invalid: "User email is invalid",
      password_required: "User password is required",
      password_invalid: "User password is invalid",
      email_used: "User email is already used"
    }

    case ValidatorService.is_not_empty?(params["password"], "") do
      {:ok, _} ->
        with {:ok, _} <- ValidatorService.is_string?(params["name"], errs.name_required),
             {:ok, _} <- ValidatorService.is_string?(params["email"], errs.email_required),
             {:ok, _} <- ValidatorService.is_string?(params["password"], errs.password_required),
             {:ok, _} <- ValidatorService.is_not_empty?(params["name"], errs.name_required),
             {:ok, _} <- ValidatorService.is_not_empty?(params["email"], errs.email_required),
             {:ok, _} <-
               ValidatorService.is_not_empty?(params["password"], errs.password_required),
             {:ok, _} <-
               ValidatorService.is_length_between?(
                 params["name"],
                 @name_min_length,
                 @name_max_length,
                 errs.name_invalid
               ),
             {:ok, _} <- ValidatorService.is_email?(params["email"], errs.email_invalid),
             {:ok, _} <- ValidatorService.is_password?(params["password"], errs.password_invalid),
             {:ok, _} <-
               ValidatorService.is_email_used?(params["email"], user_uuid, errs.email_used) do
          {:ok, ""}
        else
          {:error, reason} -> {:error, reason}
        end

      {:error, _} ->
        # Password is not provided
        with {:ok, _} <- ValidatorService.is_string?(params["name"], errs.name_required),
             {:ok, _} <- ValidatorService.is_string?(params["email"], errs.email_required),
             {:ok, _} <- ValidatorService.is_not_empty?(params["name"], errs.name_required),
             {:ok, _} <- ValidatorService.is_not_empty?(params["email"], errs.email_required),
             {:ok, _} <-
               ValidatorService.is_length_between?(
                 params["name"],
                 @name_min_length,
                 @name_max_length,
                 errs.name_invalid
               ),
             {:ok, _} <- ValidatorService.is_email?(params["email"], errs.email_invalid),
             {:ok, _} <-
               ValidatorService.is_email_used?(params["email"], user_uuid, errs.email_used) do
          {:ok, ""}
        else
          {:error, reason} -> {:error, reason}
        end
    end
  end
end
