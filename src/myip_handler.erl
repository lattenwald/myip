-module(myip_handler).

-behaviour(cowboy_handler).

-export([init/2]).

init(Req0, State) ->
    io:format("~p~n", [Req0]),
    #{peer := {Ip, _}} = Req0,
    IpBin = unicode:characters_to_binary(lists:join($., lists:map(fun integer_to_binary/1, tuple_to_list(Ip)))),
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"text/plain">>},
        IpBin,
        Req0),
    {ok, Req, State}.
