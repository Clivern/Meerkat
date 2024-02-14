# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Meerkat.Context.UserContextTest do
  @moduledoc """
  User Context Test Cases
  """
  use ExUnit.Case

  alias Meerkat.Context.UserContext
  alias Meerkat.Context.TeamContext

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Meerkat.Repo)
  end

  describe "new_user/1" do
    test "test new_user" do
      user =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      assert user.email == "hello@clivern.com"
      assert user.name == "Clivern"
      assert user.password_hash == "27hd7wh2"
      assert user.verified == true
      assert user.role == "super"
      assert user.api_key == "x-x-x-x-x"
      assert is_binary(user.uuid) == true
    end
  end

  describe "new_meta/1" do
    test "test new_meta" do
      meta =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: 1
        })

      assert meta.user_id == 1
      assert meta.key == "meta_key"
      assert meta.value == "meta_value"
    end
  end

  describe "new_session/1" do
    test "test new_session" do
      session =
        UserContext.new_session(%{
          expire_at: "expire_at",
          value: "meta_value",
          user_id: 1
        })

      assert session.user_id == 1
      assert session.expire_at == "expire_at"
      assert session.value == "meta_value"
    end
  end

  describe "create_user/1" do
    test "test create_user" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)
    end
  end

  describe "get_user_by_id/1" do
    test "test get_user_by_id" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      result = UserContext.get_user_by_id(user.id)

      assert result == user
    end
  end

  describe "get_user_by_uuid/1" do
    test "test get_user_by_uuid" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      result = UserContext.get_user_by_uuid(user.uuid)

      assert result == user
    end
  end

  describe "get_user_by_api_key/1" do
    test "test get_user_by_api_key" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      result = UserContext.get_user_by_api_key(user.api_key)

      assert result == user
    end
  end

  describe "get_user_by_email/1" do
    test "test get_user_by_email" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      result = UserContext.get_user_by_email(user.email)

      assert result == user
    end
  end

  describe "update_user/2" do
    test "test update_user" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      {_, result} = UserContext.update_user(user, %{email: "hi@clivern.com"})

      assert result.email == "hi@clivern.com"
    end
  end

  describe "delete_user/1" do
    test "test delete_user" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      UserContext.delete_user(user)

      assert UserContext.get_user_by_id(user.id) == nil
    end
  end

  describe "get_users/0" do
    test "test get_users" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      assert UserContext.get_users() == [user]
    end
  end

  describe "get_users/2" do
    test "test get_users" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      assert UserContext.get_users(0, 1) == [user]
      assert UserContext.get_users(1, 1) == []
    end
  end

  describe "count_users/0" do
    test "test count_users" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      UserContext.create_user(attr)

      assert UserContext.count_users() == 1
    end
  end

  describe "create_user_meta/1" do
    test "test create_user_meta" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      {status, meta} = UserContext.create_user_meta(attr)

      assert status == :ok
      assert meta.key == "meta_key"
      assert meta.value == "meta_value"
      assert meta.user_id == user.id
      assert meta.id > 0 == true
    end
  end

  describe "create_user_session/1" do
    test "test create_user_session" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      dt = DateTime.utc_now()

      attr =
        UserContext.new_session(%{
          expire_at: dt,
          value: "session_value",
          user_id: user.id
        })

      {status, session} = UserContext.create_user_session(attr)

      assert status == :ok
      assert session.value == "session_value"
      assert session.user_id == user.id
      assert session.id > 0 == true
    end
  end

  describe "get_user_meta_by_id/1" do
    test "test get_user_meta_by_id" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      {status, meta} = UserContext.create_user_meta(attr)

      result = UserContext.get_user_meta_by_id(meta.id)

      assert status == :ok
      assert meta == result
    end
  end

  describe "update_user_meta/2" do
    test "test update_user_meta" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      {status, meta} = UserContext.create_user_meta(attr)

      assert status == :ok
      assert meta.key == "meta_key"
      assert meta.value == "meta_value"

      {status, meta} =
        UserContext.update_user_meta(
          meta,
          %{key: "new_meta_key", value: "new_meta_value"}
        )

      assert status == :ok
      assert meta.key == "new_meta_key"
      assert meta.value == "new_meta_value"

      result = UserContext.get_user_meta_by_id(meta.id)

      assert status == :ok
      assert result.key == "new_meta_key"
      assert result.value == "new_meta_value"
    end
  end

  describe "update_user_session/2" do
    test "test update_user_session" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      dt = DateTime.utc_now()

      attr =
        UserContext.new_session(%{
          expire_at: dt,
          value: "session_value",
          user_id: user.id
        })

      {status, session} = UserContext.create_user_session(attr)

      assert status == :ok
      assert session.value == "session_value"
      assert session.user_id == user.id
      assert session.id > 0 == true

      {status, session} = UserContext.update_user_session(session, %{value: "new_session_value"})

      assert status == :ok
      assert session.value == "new_session_value"
      assert session.user_id == user.id
      assert session.id > 0 == true
    end
  end

  describe "delete_user_meta/1" do
    test "test delete_user_meta" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      {_, meta} = UserContext.create_user_meta(attr)

      UserContext.delete_user_meta(meta)

      result = UserContext.get_user_meta_by_id(meta.id)

      assert result == nil
    end
  end

  describe "delete_user_session/1" do
    test "test delete_user_session" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_session(%{
          expire_at: DateTime.utc_now(),
          value: "session_value",
          user_id: user.id
        })

      {_, session} = UserContext.create_user_session(attr)

      UserContext.delete_user_session(session)

      result = UserContext.get_user_session_by_id_value(user.id, "session_value")

      assert result == nil
    end
  end

  describe "delete_user_sessions/1" do
    test "test delete_user_sessions" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_session(%{
          expire_at: DateTime.utc_now(),
          value: "session_value",
          user_id: user.id
        })

      UserContext.create_user_session(attr)

      UserContext.delete_user_sessions(user.id)

      result = UserContext.get_user_session_by_id_value(user.id, "session_value")

      assert result == nil
    end
  end

  describe "get_user_meta_by_id_key/2" do
    test "test case" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      UserContext.create_user_meta(attr)

      result = UserContext.get_user_meta_by_id_key(user.id, "meta_key")

      assert result.key == "meta_key"
      assert result.value == "meta_value"
      assert result.user_id == user.id
    end
  end

  describe "get_user_session_by_id_key/2" do
    test "test get_user_session_by_id_key" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_session(%{
          expire_at: DateTime.utc_now(),
          value: "session_value",
          user_id: user.id
        })

      UserContext.create_user_session(attr)

      result = UserContext.get_user_session_by_id_value(user.id, "session_value")

      assert result.value == "session_value"
      assert result.user_id == user.id
    end
  end

  describe "get_user_sessions/1" do
    test "test get_user_sessions" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      dt = DateTime.utc_now()

      attr =
        UserContext.new_session(%{
          expire_at: dt,
          value: "session_value",
          user_id: user.id
        })

      {_, session} = UserContext.create_user_session(attr)

      result = UserContext.get_user_sessions(user.id)

      assert result == [session]

      result = UserContext.get_user_sessions(1000)

      assert result == []
    end
  end

  describe "get_user_metas/1" do
    test "test get_user_metas" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {_, user} = UserContext.create_user(attr)

      attr =
        UserContext.new_meta(%{
          key: "meta_key",
          value: "meta_value",
          user_id: user.id
        })

      {_, meta} = UserContext.create_user_meta(attr)

      result = UserContext.get_user_metas(user.id)

      assert result == [meta]

      result = UserContext.get_user_metas(1000)

      assert result == []
    end
  end

  describe "add_user_to_team/2" do
    test "test case" do
    end
  end

  describe "remove_user_from_team/2" do
    test "test case" do
    end
  end

  describe "remove_user_from_team_by_uuid/1" do
    test "test case" do
    end
  end

  describe "get_user_teams/1" do
    test "test case" do
    end
  end

  describe "get_team_users/1" do
    test "test case" do
    end
  end

  describe "validate_user_id/1" do
    test "test validate_user_id" do
      attr =
        UserContext.new_user(%{
          email: "hello@clivern.com",
          name: "Clivern",
          password_hash: "27hd7wh2",
          verified: true,
          last_seen: DateTime.utc_now(),
          role: "super",
          api_key: "x-x-x-x-x"
        })

      {status, user} = UserContext.create_user(attr)

      assert status == :ok
      assert user.email == "hello@clivern.com"
      assert is_binary(user.uuid)

      assert UserContext.validate_user_id(user.id) == true
    end
  end

  describe "validate_team_id/1" do
    test "test validate_team_id" do
      attrs =
        TeamContext.new_team(%{
          name: "Team 2",
          description: "Description 2"
        })

      {status, team} = TeamContext.create_team(attrs)

      assert status == :ok

      assert team.name == "Team 2"
      assert team.description == "Description 2"
      assert is_binary(team.uuid)

      assert UserContext.validate_team_id(team.id) == true
    end
  end
end
