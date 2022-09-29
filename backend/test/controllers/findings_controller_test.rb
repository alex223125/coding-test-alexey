require "test_helper"

class FindingsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @finding = findings(:one)
  end

  test "should get index" do
    get findings_url, as: :json
    assert_response :success
  end

  test "should create finding" do
    assert_difference('Finding.count') do
      post findings_url, params: { finding: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show finding" do
    get finding_url(@finding), as: :json
    assert_response :success
  end

  test "should update finding" do
    patch finding_url(@finding), params: { finding: {  } }, as: :json
    assert_response 200
  end

  test "should destroy finding" do
    assert_difference('Finding.count', -1) do
      delete finding_url(@finding), as: :json
    end

    assert_response 204
  end
end
