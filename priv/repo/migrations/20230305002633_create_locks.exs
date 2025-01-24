# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Scuti.Repo.Migrations.CreateLocks do
  use Ecto.Migration

  def change do
    create table(:locks) do
      add :uuid, :uuid
      add :key, :string, unique: true
      add :status, :string

      timestamps()
    end

    create index(:locks, [:key])
  end
end
