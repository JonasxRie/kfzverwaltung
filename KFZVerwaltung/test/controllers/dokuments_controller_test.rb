require 'test_helper'

class DokumentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dokument = dokuments(:one)
  end

  test "should get index" do
    get dokuments_url
    assert_response :success
  end

  test "should get new" do
    get new_dokument_url
    assert_response :success
  end

  test "should create dokument" do
    assert_difference('Dokument.count') do
      post dokuments_url, params: { dokument: { bezeichnung: @dokument.bezeichnung, datei: @dokument.datei, fahrzeug_id: @dokument.fahrzeug_id, speicherdatum: @dokument.speicherdatum, typ: @dokument.typ } }
    end

    assert_redirected_to dokument_url(Dokument.last)
  end

  test "should show dokument" do
    get dokument_url(@dokument)
    assert_response :success
  end

  test "should get edit" do
    get edit_dokument_url(@dokument)
    assert_response :success
  end

  test "should update dokument" do
    patch dokument_url(@dokument), params: { dokument: { bezeichnung: @dokument.bezeichnung, datei: @dokument.datei, fahrzeug_id: @dokument.fahrzeug_id, speicherdatum: @dokument.speicherdatum, typ: @dokument.typ } }
    assert_redirected_to dokument_url(@dokument)
  end

  test "should destroy dokument" do
    assert_difference('Dokument.count', -1) do
      delete dokument_url(@dokument)
    end

    assert_redirected_to dokuments_url
  end
end
