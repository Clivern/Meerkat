# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Meerkat.Context.LockContext do
  @moduledoc """
  Lock Context Module
  """

  import Ecto.Query
  alias Meerkat.Repo
  alias Meerkat.Model.{LockMeta, Lock}

  @doc """
  Get a new lock
  """
  def new_lock(lock \\ %{}) do
    %{
      project_id: lock.project_id,
      uuid: lock.uuid,
      operation: lock.operation,
      info: lock.info,
      who: lock.who,
      version: lock.version,
      path: lock.path,
      is_active: lock.is_active
    }
  end

  @doc """
  Create a lock meta
  """
  def new_meta(meta \\ %{}) do
    %{
      key: meta.key,
      value: meta.value,
      lock_id: meta.lock_id
    }
  end

  @doc """
  Create a new lock
  """
  def create_lock(attrs \\ %{}) do
    %Lock{}
    |> Lock.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get a lock by id
  """
  def get_lock_by_id(id) do
    Repo.get(Lock, id)
  end

  @doc """
  Get a lock by uuid
  """
  def get_lock_by_uuid(uuid) do
    from(
      l in Lock,
      where: l.uuid == ^uuid
    )
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Get active lock by project id
  """
  def get_active_lock_by_project_id(project_id) do
    from(
      l in Lock,
      where: l.project_id == ^project_id,
      where: l.is_active == true
    )
    |> lock("FOR UPDATE")
    |> limit(1)
    |> Repo.one()
  end

  @doc """
  Update a lock
  """
  def update_lock(lock, attrs) do
    lock
    |> Lock.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Delete a lock
  """
  def delete_lock(lock) do
    Repo.delete(lock)
  end

  @doc """
  Retrieve all locks
  """
  def get_locks() do
    Repo.all(Lock)
  end

  @doc """
  Create a new lock meta
  """
  def create_lock_meta(attrs \\ %{}) do
    %LockMeta{}
    |> LockMeta.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Get lock meta by id
  """
  def get_lock_meta_by_id(id) do
    Repo.get(LockMeta, id)
  end

  @doc """
  Update lock meta
  """
  def update_lock_meta(lock_meta, attrs) do
    LockMeta.changeset(lock_meta, attrs)
    |> Repo.update()
  end

  @doc """
  Delete lock meta
  """
  def delete_lock_meta(lock_meta) do
    Repo.delete(lock_meta)
  end

  @doc """
  Get lock meta by id and key
  """
  def get_lock_meta_by_id_key(lock_id, meta_key) do
    from(
      l in LockMeta,
      where: l.lock_id == ^lock_id,
      where: l.key == ^meta_key
    )
    |> Repo.one()
  end

  @doc """
  Get lock metas
  """
  def get_lock_metas(lock_id) do
    from(
      l in LockMeta,
      where: l.lock_id == ^lock_id
    )
    |> Repo.all()
  end
end
