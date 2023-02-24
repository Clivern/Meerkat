# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Scuti.Model.Lock do
  @moduledoc """
  Lock Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "locks" do
    field :uuid, Ecto.UUID
    field :key, :string
    field :version, :string
    field :status, :string

    timestamps()
  end

  @doc false
  def changeset(config, attrs) do
    config
    |> cast(attrs, [
      :uuid,
      :name,
      :value
    ])
    |> validate_required([
      :uuid,
      :name,
      :value
    ])
    |> validate_length(:name, min: 3, max: 200)
    |> validate_length(:value, min: 3, max: 2000)
  end
end
