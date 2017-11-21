require 'test_helper'

class FahrzeugsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @fahrzeug = fahrzeugs(:one)
  end

  test "should get index" do
    get fahrzeugs_url
    assert_response :success
  end

  test "should get new" do
    get new_fahrzeug_url
    assert_response :success
  end

  test "should create fahrzeug" do
    assert_difference('Fahrzeug.count') do
      post fahrzeugs_url, params: { fahrzeug: { archiviert: @fahrzeug.archiviert, baujahr: @fahrzeug.baujahr, bezeichnung: @fahrzeug.bezeichnung, kennzeichen: @fahrzeug.kennzeichen, notizen: @fahrzeug.notizen, tuv: @fahrzeug.tuv } }
    end

    assert_redirected_to fahrzeug_url(Fahrzeug.last)
  end

  test "should show fahrzeug" do
    get fahrzeug_url(@fahrzeug)
    assert_response :success
  end

  test "should get edit" do
    get edit_fahrzeug_url(@fahrzeug)
    assert_response :success
  end

  test "should update fahrzeug" do
    patch fahrzeug_url(@fahrzeug), params: { fahrzeug: { archiviert: @fahrzeug.archiviert, baujahr: @fahrzeug.baujahr, bezeichnung: @fahrzeug.bezeichnung, kennzeichen: @fahrzeug.kennzeichen, notizen: @fahrzeug.notizen, tuv: @fahrzeug.tuv } }
    assert_redirected_to fahrzeug_url(@fahrzeug)
  end

  test "should destroy fahrzeug" do
    assert_difference('Fahrzeug.count', -1) do
      delete fahrzeug_url(@fahrzeug)
    end

    assert_redirected_to fahrzeugs_url
  end
end
