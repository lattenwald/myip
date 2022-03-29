%%%-------------------------------------------------------------------
%% @doc myip public API
%% @end
%%%-------------------------------------------------------------------

-module(myip_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    Dispatch = cowboy_router:compile([{'_', [{"/", myip_handler, []}]}]),
    {ok, _} = cowboy:start_clear(
                myip_http_listener,
                [{port, 8080}],
                #{env => #{dispatch => Dispatch}}),
    myip_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
