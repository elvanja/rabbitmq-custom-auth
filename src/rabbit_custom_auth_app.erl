-module(rabbit_custom_auth_app).

-behaviour(application).
-export([start/2, stop/1]).

-behaviour(supervisor).
-export([init/1]).

start(_Type, _StartArgs) ->
  rabbit_log:info("===== custom auth start"),
  supervisor:start_link({local,?MODULE},?MODULE,[]).

stop(_State) ->
  rabbit_log:info("===== custom auth stop"),
  ok.

init([]) ->
  rabbit_log:info("===== custom auth init"),
  {ok, {{one_for_one,3,10},[]}}.
