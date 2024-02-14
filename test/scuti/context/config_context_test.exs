# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule Scuti.Context.ConfigContextTest do
  @moduledoc """
  Lock Context Test Cases
  """
  use Scuti.DataCase
  alias Scuti.Context.ConfigContext, as: ConfigContext

  setup do
    :ok = Ecto.Adapters.SQL.Sandbox.checkout(Scuti.Repo)
  end

  describe "new_config/1" do
    # new_config/1
    test "new_config/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "scuti"
        })

      assert item.name == "app_name"
      assert item.value == "scuti"
      assert item.uuid != ""
    end
  end

  describe "create_config/1" do
    # create_config/1
    test "create_config/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "scuti"
        })

      {:ok, result} = ConfigContext.create_config(item)

      assert result.name == "app_name"
      assert result.value == "scuti"
      assert result.uuid != ""
      assert result.id != ""
    end
  end

  describe "get_config_by_id/1" do
    # get_config_by_id/1
    test "get_config_by_id/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "scuti"
        })

      {:ok, result} = ConfigContext.create_config(item)

      conf = ConfigContext.get_config_by_id(result.id)

      assert conf.name == "app_name"
      assert conf.value == "scuti"
      assert conf.uuid != ""
      assert conf.id != ""
    end
  end

  describe "get_config_by_uuid/1" do
    # get_config_by_uuid/1
    test "get_config_by_uuid/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "scuti"
        })

      {:ok, result} = ConfigContext.create_config(item)

      conf = ConfigContext.get_config_by_uuid(result.uuid)

      assert conf.name == "app_name"
      assert conf.value == "scuti"
      assert conf.uuid != ""
      assert conf.id != ""
    end
  end

  describe "get_config_by_name/1" do
    # get_config_by_name/1
    test "get_config_by_name/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "scuti"
        })

      {:ok, result} = ConfigContext.create_config(item)

      conf = ConfigContext.get_config_by_name(result.name)

      assert conf.name == "app_name"
      assert conf.value == "scuti"
      assert conf.uuid != ""
      assert conf.id != ""
    end
  end

  describe "update_config/2" do
    # update_config/2
    test "update_config/2 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "scuti"
        })

      {:ok, result} = ConfigContext.create_config(item)

      {:ok, conf} =
        ConfigContext.update_config(result, %{
          value: "timber"
        })

      assert conf.name == "app_name"
      assert conf.value == "timber"
      assert conf.uuid != ""
      assert conf.id != ""
    end
  end

  describe "delete_config/1" do
    # delete_config/1
    test "delete_config/1 test cases" do
      item =
        ConfigContext.new_config(%{
          name: "app_name",
          value: "scuti"
        })

      {:ok, result} = ConfigContext.create_config(item)

      ConfigContext.delete_config(result)
      conf = ConfigContext.get_config_by_name(result.name)

      assert conf == nil
    end
  end
end
