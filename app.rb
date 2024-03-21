require "sinatra"
require "sinatra/reloader"
require "better_errors"
require "binding_of_caller"
use(BetterErrors::Middleware)
BetterErrors.application_root = __dir__
BetterErrors::Middleware.allow_ip!('0.0.0.0/0.0.0.0')

get("/") do
  erb(:square_new)
end

get("/square/new") do
 erb(:square_new)
end

get("/square/results") do
  @sq_number = params.fetch("user_number").to_f
  @sq_result = @sq_number ** 2
  erb(:square_results)
end

get("/square_root/new")do
 erb(:squareroot_new)
end

get("/square_root/results") do
  @sqr_number = params.fetch("number").to_f
  @sqr_result = Math.sqrt(@sqr_number)
  erb(:square_root_results)
end


get("/payment/new") do
  erb(:payment_new)
end

get("/payment/results") do
  r = params.fetch("user_apr").to_f / 100 / 12
  @p_apr = params.fetch("user_apr").to_f.to_fs(:percentage, {:precison => 4})
  @p_years = params.fetch("user_years").to_i
  n = @p_years * 12
  pv = params.fetch("user_pv").to_f
  @p_principal = pv.to_fs(:currency)
  p = (r * pv) / (1 - ((1 + r) ** (-n)))
  @p_result = p.to_fs(:currency)
  erb(:payment_results)
end
