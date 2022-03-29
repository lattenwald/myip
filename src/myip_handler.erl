-module(myip_handler).

-behaviour(cowboy_handler).

-export([init/2]).

init(Req0, State) ->
    #{headers := Headers, peer := {Ip, _}} = Req0,
    IpBin = case maps:get(<<"x-real-ip">>, Headers, null) of
                null -> unicode:characters_to_binary(lists:join($., lists:map(fun integer_to_binary/1, tuple_to_list(Ip))));
                XRealIp -> XRealIp
            end,
    Req = cowboy_req:reply(200,
        #{<<"content-type">> => <<"text/plain">>},
        IpBin,
        Req0),
    {ok, Req, State}.
