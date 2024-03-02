# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule ScutiWeb.ProfileController do
  @moduledoc """
  Profile Controller
  """

  use ScutiWeb, :controller

  require Logger

  plug :regular_user, only: [:update]

  defp regular_user(conn, _opts) do
    Logger.info("Validate user permissions. RequestId=#{conn.assigns[:request_id]}")

    if not conn.assigns[:is_logged] do
      Logger.info(
        "User doesn't have the right access permissions. RequestId=#{conn.assigns[:request_id]}"
      )

      conn
      |> put_status(:forbidden)
      |> render("error.json", %{message: "Forbidden Access"})
    else
      Logger.info("User has the right access permissions. RequestId=#{conn.assigns[:request_id]}")

      conn
    end
  end

  @doc """
  Update Profile Endpoint
  """
  def update(conn, params) do
    IO.inspect(params)

    conn
    |> put_status(:ok)
    |> render("success.json", %{message: "Profile updated successfully"})
  end
end
