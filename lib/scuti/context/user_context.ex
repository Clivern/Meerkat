# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Scuti.Context.UserContext do
  @moduledoc """
  User Context Module
  """

  import Ecto.Query

  alias Scuti.Repo
  alias Scuti.Model.{Team, UserMeta, User, UserSession, UserTeam}

  @doc """
  Creates a new user with the provided attributes
  """
  def new_user(attrs \\ %{}) do
    %{
      email: attrs.email,
      name: attrs.name,
      password_hash: attrs.password_hash,
      verified: attrs.verified,
      last_seen: attrs.last_seen,
      role: attrs.role,
      api_key: attrs.api_key,
      uuid: Map.get(attrs, :uuid, Ecto.UUID.generate())
    }
  end

  @doc """
  Creates a new user meta with the provided attributes
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      user_id: meta.user_id
    }
  end

  @doc """
  Creates a new user session with the provided attributes
  """
  def new_session(session \\ %{}) do
    %{
      value: session.value,
      expire_at: session.expire_at,
      user_id: session.user_id
    }
  end

  @doc """
  Creates a new user record in the database
  """
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieves a user record by its ID
  """
  def get_user_by_id(id) do
    Repo.get(User, id)
  end

  @doc """
  Retrieves the ID of a user by its UUID
  """
  def get_user_id_with_uuid(uuid) do
    case get_user_by_uuid(uuid) do
      nil ->
        nil

      user ->
        user.id
    end
  end

  @doc """
  Retrieves a user record by its UUID
  """
  def get_user_by_uuid(uuid) do
    from(
      u in User,
      where: u.uuid == ^uuid
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Get user by API Key
  """
  def get_user_by_api_key(api_key) do
    from(
      u in User,
      where: u.api_key == ^api_key
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Get user by email
  """
  def get_user_by_email(email) do
    from(
      u in User,
      where: u.email == ^email
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Update a user
  """
  def update_user(user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a user
  """
  def delete_user(user) do
    Repo.delete(user)
  end

  @doc """
  Retrieve all users
  """
  def get_users() do
    Repo.all(User)
  end

  @doc """
  Retrieve users
  """
  def get_users(offset, limit) do
    from(u in User,
      order_by: [desc: u.inserted_at],
      limit: ^limit,
      offset: ^offset
    )
    |> Repo.all()
  end

  @doc """
  Count all users
  """
  def count_users() do
    from(u in User,
      select: count(u.id)
    )
    |> Repo.one()
  end

  @doc """
  Create a new user meta
  """
  def create_user_meta(attrs \\ %{}) do
    %UserMeta{}
    |> UserMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Create a new user session
  """
  def create_user_session(attrs \\ %{}) do
    %UserSession{}
    |> UserSession.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Retrieve a user meta by id
  """
  def get_user_meta_by_id(id) do
    Repo.get(UserMeta, id)
  end

  @doc """
  Update a user meta
  """
  def update_user_meta(user_meta, attrs) do
    user_meta
    |> UserMeta.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Update a user session
  """
  def update_user_session(user_session, attrs) do
    user_session
    |> UserSession.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a user meta
  """
  def delete_user_meta(user_meta) do
    Repo.delete(user_meta)
  end

  @doc """
  Delete a user session
  """
  def delete_user_session(user_session) do
    Repo.delete(user_session)
  end

  @doc """
  Delete user sessions
  """
  def delete_user_sessions(user_id) do
    from(
      u in UserSession,
      where: u.user_id == ^user_id
    )
    |> Repo.delete_all()
  end

  @doc """
  Get user meta by user id and key
  """
  def get_user_meta_by_id_key(user_id, meta_key) do
    from(
      u in UserMeta,
      where: u.user_id == ^user_id,
      where: u.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get user session by user id and value
  """
  def get_user_session_by_id_value(user_id, value) do
    from(
      u in UserSession,
      where: u.user_id == ^user_id,
      where: u.value == ^value
    )
    |> Repo.one()
  end

  @doc """
  Get user sessions
  """
  def get_user_sessions(user_id) do
    from(
      u in UserSession,
      where: u.user_id == ^user_id
    )
    |> Repo.all()
  end

  @doc """
  Get user metas
  """
  def get_user_metas(user_id) do
    from(
      u in UserMeta,
      where: u.user_id == ^user_id
    )
    |> Repo.all()
  end

  @doc """
  Add a user to a team
  """
  def add_user_to_team(user_id, team_id) do
    %UserTeam{}
    |> UserTeam.changeset(%{
      user_id: user_id,
      team_id: team_id,
      uuid: Ecto.UUID.generate()
    })
    |> Repo.insert()
  end

  @doc """
  Remove user from a team
  """
  def remove_user_from_team(user_id, team_id) do
    from(
      u in UserTeam,
      where: u.user_id == ^user_id,
      where: u.team_id == ^team_id
    )
    |> Repo.delete_all()
  end

  @doc """
  Remove user from a team by UUID
  """
  def remove_user_from_team_by_uuid(uuid) do
    from(
      u in UserTeam,
      where: u.uuid == ^uuid
    )
    |> Repo.delete_all()
  end

  @doc """
  Get user teams
  """
  def get_user_teams(user_id) do
    teams = []

    items =
      from(
        u in UserTeam,
        where: u.user_id == ^user_id
      )
      |> Repo.all()

    for item <- items do
      team = Repo.get(Team, item.team_id)

      case team do
        nil ->
          nil

        _ ->
          teams ++ team
      end
    end
  end

  @doc """
  Count team users
  """
  def count_team_users(team_id) do
    from(u in UserTeam,
      select: count(u.id),
      where: u.team_id == ^team_id
    )
    |> Repo.one()
  end

  @doc """
  Count user teams
  """
  def count_user_teams(user_id) do
    from(u in UserTeam,
      select: count(u.id),
      where: u.user_id == ^user_id
    )
    |> Repo.one()
  end

  @doc """
  Get team users
  """
  def get_team_users(team_id) do
    users = []

    items =
      from(
        u in UserTeam,
        where: u.team_id == ^team_id
      )
      |> Repo.all()

    for item <- items do
      user = Repo.get(User, item.user_id)

      case user do
        nil ->
          nil

        _ ->
          users ++ user
      end
    end
  end

  @doc """
  Validate user id
  """
  def validate_user_id(user_id) do
    user = Repo.get(User, user_id)

    case user do
      nil ->
        false

      _ ->
        true
    end
  end

  @doc """
  Validate team id
  """
  def validate_team_id(team_id) do
    team = Repo.get(Team, team_id)

    case team do
      nil ->
        false

      _ ->
        true
    end
  end
end
