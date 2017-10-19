# -*- coding: utf-8 -*-

if ![4, 5].include?(ARGV.length)
  $stderr.puts(<<-EOS)
Usage:
  update.rb <patient_id> <in_out> <invoice_number> <ic_money> [force]
    in_out: i or o
    force: t
  EOS
  exit(1)
end

require_relative "../common"

income_service = @orca_api.new_income_service

patient_id = ARGV.shift
in_out = ARGV.shift.upcase
invoice_number = ARGV.shift
ic_money = ARGV.shift
force = ARGV.shift ? "True" : "False"

args = {
  "Patient_ID" => patient_id, # 患者番号/必須/20
  "InOut" => in_out, # 入外区分、I:入院/O:外来/必須/1
  "Invoice_Number" => invoice_number, # 伝票番号/必須/7
  "Processing_Date" => "", # 処理日/任意/10/未設定時の初期値はシステム日付（実際の処理日）
  "Processing_Time" => "", # 処理時刻/任意/8/未設定時の初期値はシステム時刻（実際の処理時刻）
  "Ic_Money" => ic_money, # 入金額/必須/10
  "Ic_Code" => "", # 入金方法/システム管理［1041 入金方法情報］より設定/任意/2/未設定時の初期値は患者登録設定内容
  "Force_Flg" => force, # 強制入金フラグ、True:請求金額＜入金額となる入金をエラーとしない、False:請求金額＜入金額となる入金をエラーとする/任意/5/未設定時の初期値は"False"
}
result = income_service.update(args)
if result.ok?
  print_result(result)
else
  error(result)
end
