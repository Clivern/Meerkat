# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Scuti.Model.Deployment do
  @moduledoc """
  Deployment Model
  """

  use Ecto.Schema
  import Ecto.Changeset

  schema "deployments" do
    field :uuid, Ecto.UUID
    field :name, :string
    field :description, :string
    field :team_id, :id

    # Hosts Filters
    field :hosts_filter, :string
    field :host_groups_filter, :string

    # :os_upgrade || :distribution_upgrade || :custom_system_patch
    field :patch_type, :string

    # ALWAYS Available
    field :pre_patch_script, :string
    field :patch_script, :string
    field :post_patch_script, :string
    # :always || :only_if_needed || :never
    field :post_patch_reboot_option, :string

    # :one_by_one || :all_at_once || :percent || :count
    field :rollout_strategy, :string
    # 10% || 20
    field :rollout_strategy_value, :string

    # :once || :recursive
    field :schedule_type, :string
    field :schedule_time, :utc_datetime

    # :unknown || :pending || :running || :success || :failure || :skipped
    field :last_status, :string
    field :last_run_at, :utc_datetime

    timestamps()
  end

  @doc false
  def changeset(deployment, attrs) do
    deployment
    |> cast(attrs, [
      :uuid,
      :team_id,
      :name,
      :description,
      :hosts_filter,
      :host_groups_filter,
      :patch_type,
      :pre_patch_script,
      :patch_script,
      :post_patch_script,
      :post_patch_reboot_option,
      :rollout_strategy,
      :rollout_strategy_value,
      :schedule_type,
      :schedule_time,
      :last_status,
      :last_run_at
    ])
    |> validate_required([
      :uuid,
      :team_id,
      :name,
      :description,
      :hosts_filter,
      :host_groups_filter,
      :patch_type,
      :post_patch_reboot_option,
      :rollout_strategy,
      :schedule_type,
      :schedule_time,
      :last_status,
      :last_run_at
    ])
  end
end
