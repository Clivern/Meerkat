# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule ScutiWeb.DeploymentView do
  use ScutiWeb, :view

  alias Scuti.Module.TeamModule

  # Render deployments list
  def render("list.json", %{deployments: deployments, metadata: metadata}) do
    %{
      deployments: Enum.map(deployments, &render_group/1),
      _metadata: %{
        limit: metadata.limit,
        offset: metadata.offset,
        totalCount: metadata.totalCount
      }
    }
  end

  # Render deployment
  def render("index.json", %{deployment: deployment}) do
    render_group(deployment)
  end

  # Render errors
  def render("error.json", %{message: message}) do
    %{errorMessage: message}
  end

  # Format deployment
  defp render_group(deployment) do
    {_, team} = TeamModule.get_team_by_id(deployment.team_id)

    %{
      id: deployment.uuid,
      name: deployment.name,
      description: deployment.description,
      team: %{
        id: team.uuid,
        name: team.name
      },
      hosts_filter: deployment.hosts_filter,
      host_groups_filter: deployment.host_groups_filter,
      patch_type: deployment.patch_type,
      pre_patch_script: deployment.pre_patch_script,
      patch_script: deployment.patch_script,
      post_patch_script: deployment.post_patch_script,
      post_patch_reboot_option: deployment.post_patch_reboot_option,
      rollout_strategy: deployment.rollout_strategy,
      rollout_strategy_value: deployment.rollout_strategy_value,
      schedule_type: deployment.schedule_type,
      schedule_time: deployment.schedule_time,
      last_status: deployment.last_status,
      last_run_at: deployment.last_run_at,
      createdAt: deployment.inserted_at,
      updatedAt: deployment.updated_at
    }
  end
end
