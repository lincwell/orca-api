# coding: utf-8

require_relative "service"

module OrcaApi
  # 患者の病名情報を扱うサービスを表現したクラス
  class DiseaseService < Service
    # 患者の病名情報の取得
    def get(params)
      body = {
        "disease_inforeq" => params,
      }
      Result.new(orca_api.call("/api01rv2/diseasegetv2", params: { "class" => "01" }, body: body))
    end
  end
end
