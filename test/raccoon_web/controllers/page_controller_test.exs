# Copyright 2023 Clivern. All rights reserved.
# Use of this source code is governed by the MIT
# license that can be found in the LICENSE file.

defmodule MeerkatWeb.PageControllerTest do
  use MeerkatWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/install")
    assert html_response(conn, 200) =~ "Clivern"
  end
end
