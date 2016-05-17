-module(rabbit_custom_auth).

-include_lib("rabbit_common/include/rabbit.hrl").

-behaviour(rabbit_auth_mechanism).
-behaviour(rabbit_authn_backend).
-behaviour(rabbit_authz_backend).

-export([description/0]).
-export([should_offer/1, init/1, handle_response/2]).
-export([user_login_authentication/2, user_login_authorization/1, check_vhost_access/3, check_resource_access/3]).

-record(state, {username = undefined}).

-rabbit_boot_step({?MODULE,
                   [{description, "Custom auth mechanism"},
                    {mfa,         {rabbit_registry, register,
                                   [auth_mechanism, <<"CUSTOM">>, ?MODULE]}},
                    {requires,    rabbit_registry},
                    {enables,     kernel_ready},
                    {cleanup,     {rabbit_registry, unregister,
                                   [auth_mechanism, <<"CUSTOM">>]}}]}).

handle_response(Response, Custom) ->
    rabbit_log:info("===== handle_response"),
    rabbit_log:info("~p~n", [Response]),
    rabbit_log:info("~p~n", [Custom]),
    {ok, #auth_user{username = "guest",
                    impl     = none}}.

init(Sock) ->
    rabbit_log:info("===== init"),
    rabbit_log:info("~p~n", [Sock]),
    #state{}.

should_offer(Sock) ->
    rabbit_log:info("===== should_offer"),
    rabbit_log:info("~p~n", [Sock]),
    true.

description() ->
    [{name, <<"customAuth">>},
     {description, <<"custom Authentication & Authorization">>}].

user_login_authentication(Username, AuthProps) ->
    rabbit_log:info("===== user_login_authentication"),
    rabbit_log:info("~p~n", [Username]),
    rabbit_log:info("~p~n", [AuthProps]),
%    authenticate(Username, AuthProps),
%    {refused, "Denied by customAuth plugin", []}.
    {ok, #auth_user{username = Username,
                    tags     = [management],
                    impl     = none}}.

user_login_authorization(Username) ->
    case user_login_authentication(Username, []) of
        {ok, #auth_user{impl = Impl}} -> {ok, Impl};
        Else                          -> Else
    end.

%check_vhost_access(#auth_user{username = Username}, VHost, _Sock) ->
check_vhost_access(AuthUser, VHost, Sock) ->
    rabbit_log:info("===== check_vhost_access"),
    rabbit_log:info("~p~n", [AuthUser]),
    rabbit_log:info("~p~n", [VHost]),
    rabbit_log:info("~p~n", [Sock]),
    true.

%check_resource_access(#auth_user{username = Username},
%                      #resource{virtual_host = VHost, kind = Type, name = Name},
%                      Permission) ->
check_resource_access(AuthUser,
                      Resource,
                      Permission) ->
    rabbit_log:info("===== check_resource_access"),
    rabbit_log:info("~p~n", [AuthUser]),
    rabbit_log:info("~p~n", [Resource]),
    rabbit_log:info("~p~n", [Permission]),
    true.
