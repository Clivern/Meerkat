# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule ScutiWeb.AgentController do
  @moduledoc """
  Agent Controller
  """
  @doc """
  Join Action Endpoint
  """
  def join(conn, _params) do
  end

  @doc """
  Heartbeat Action Endpoint
  """
  def heartbeat(conn, _params) do
  end

  @doc """
  Report Action Endpoint

  encrypt(encode({
    type: ...
    record: ....
  }), agent_secret)
  """
  def report(conn, _params) do
  end
end
