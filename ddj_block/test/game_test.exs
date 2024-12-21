defmodule GameTest do
  use ExUnit.Case

  # あたり判定テスト
  test_params = [
    [100, 100, 10, 10, 90, 90, 10, 10, true],
    [100, 100, 10, 10, 90, 110, 10, 10, true],
    [100, 100, 10, 10, 110, 90, 10, 10, true],
    [100, 100, 10, 10, 110, 110, 10, 10, true],
    [100, 100, 10, 10, 89, 89, 10, 10, false],
    [100, 100, 10, 10, 89, 111, 10, 10, false],
    [100, 100, 10, 10, 111, 89, 10, 10, false],
    [100, 100, 10, 10, 111, 111, 10, 10, false],
    [100, 100, 10, 10, 91, 91, 10, 10, true],
    [100, 100, 10, 10, 91, 109, 10, 10, true],
    [100, 100, 10, 10, 109, 91, 10, 10, true],
    [100, 100, 10, 10, 109, 109, 10, 10, true],
    [100, 100, 10, 10, 88, 88, 10, 10, false],
    [100, 100, 10, 10, 88, 112, 10, 10, false],
    [100, 100, 10, 10, 112, 88, 10, 10, false],
    [100, 100, 10, 10, 112, 112, 10, 10, false],
    [100, 100, 10, 10, 89, 90, 10, 10, false],
    [100, 100, 10, 10, 90, 111, 10, 10, false],
    [100, 100, 9, 10, 110, 90, 10, 10, false],
    [100, 100, 10, 9, 110, 110, 10, 10, false],
    [90, 90, 10, 10, 100, 100, 10, 10, true],
    [90, 110, 10, 10, 100, 100, 10, 10, true],
    [110, 90, 10, 10, 100, 100, 10, 10, true],
    [110, 110, 10, 10, 100, 100, 10, 10, true],
    [89, 89, 10, 10, 100, 100, 10, 10, false],
    [89, 111, 10, 10, 100, 100, 10, 10, false],
    [111, 89, 10, 10, 100, 100, 10, 10, false],
    [111, 111, 10, 10, 100, 100, 10, 10, false],
    [91, 91, 10, 10, 100, 100, 10, 10, true],
    [91, 109, 10, 10, 100, 100, 10, 10, true],
    [109, 91, 10, 10, 100, 100, 10, 10, true],
    [109, 109, 10, 10, 100, 100, 10, 10, true],
    [88, 88, 10, 10, 100, 100, 10, 10, false],
    [88, 112, 10, 10, 100, 100, 10, 10, false],
    [112, 88, 10, 10, 100, 100, 10, 10, false],
    [112, 112, 10, 10, 100, 100, 10, 10, false],
    [89, 90, 10, 10, 100, 100, 10, 10, false],
    [90, 111, 10, 10, 100, 100, 10, 10, false],
    [110, 90, 10, 10, 100, 100, 9, 10, false],
    [110, 110, 10, 10, 100, 100, 10, 9, false]
  ]

  for test_param <- test_params do
    @test_param test_param
    test "collided #{inspect(@test_param)}" do
      [x1, y1, w1, h1, x2, y2, w2, h2, ret] = @test_param
      assert Game.collided?(x1, y1, w1, h1, x2, y2, w2, h2) == ret
    end
  end

  test "collided list false and true return true" do
    x1 = 100
    y1 = 100
    w1 = 10
    h1 = 10

    judgments = [
      [111, 111, 10, 10],
      [91, 91, 10, 10]
    ]

    assert Game.collided?(x1, y1, w1, h1, judgments)
  end

  test "collided list false and false return false" do
    x1 = 100
    y1 = 100
    w1 = 10
    h1 = 10

    judgments = [
      [89, 89, 10, 10],
      [89, 111, 10, 10]
    ]

    refute Game.collided?(x1, y1, w1, h1, judgments)
  end

  test "collided_with_filter false and true return true" do
    x1 = 100
    y1 = 100
    w1 = 10
    h1 = 10

    judgments = [
      [111, 111, 10, 10],
      [91, 91, 10, 10]
    ]

    assert Game.collided_with_filter(x1, y1, w1, h1, judgments) ==
             {true, [[111, 111, 10, 10]]}
  end

  test "collided_with_filter false and false return false" do
    x1 = 100
    y1 = 100
    w1 = 10
    h1 = 10

    judgments = [
      [89, 89, 10, 10],
      [89, 111, 10, 10]
    ]

    assert Game.collided_with_filter(x1, y1, w1, h1, judgments) ==
             {false, [[89, 89, 10, 10], [89, 111, 10, 10]]}
  end
end
