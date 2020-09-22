print("<-------------------------->")
print("| Loading wscore...        |")
print("<-------------------------->")
require("gwsockets")
print("\n")
print("<-------------------------->")
print("| Functions:               |")
print("<-------------------------->")
E2Lib.RegisterExtension( "wscore", true, "Connects to websocket servers using E2.", "It allows any E2 to make a connection to any websocket servers, even to your internal network. " )

local cvar_maxsockets = CreateConVar( "wire_expression2_max_ws_instances", "2", FCVAR_ARCHIVE )

local run_on = {
    ents = {}
}

__e2setcost( 20 )

print("added wsCreateConnection!")
e2function void wsCreateConnection( number id, string url )
    local myID = id
    local This = self
    self.data.sockets = self.data.sockets or {}

    if table.Count(self.data.sockets) > cvars.Number("wire_expression2_max_ws_instances", 2) or
       url == "" or
       self.data.sockets[myID] ~= nil then return end

    local socket = GWSockets.createWebSocket( url )

    self.data.sockets[myID] = {
        socket=socket,
        url=url,
        headers=headers,
        cookies=cookies
    }

    function socket:onConnected()
        This.data.sockets[myID].isConnected = true
        if IsValid(This.entity) and run_on.ents[This.entity] then

            This.data.sockets[myID].connected = 1
            This.entity:Execute()
            This.data.sockets[myID].connected = nil
        end
    end

    function socket:onDisconnected()
        This.data.sockets[myID].isConnected = false

        if IsValid(This.entity) and run_on.ents[This.entity] then
            This.data.sockets[myID].disconnected = 1
            This.entity:Execute()
            This.data.sockets[myID].disconnected = nil
        end
    end

    function socket:onMessage(msg)
        if IsValid(This.entity) and run_on.ents[This.entity] then
            This.data.sockets[myID].data = 1
            This.data.sockets[myID].msg = msg
            This.entity:Execute()
            This.data.sockets[myID].data = nil
            This.data.sockets[myID].msg = nil
        end
    end

    function socket:onError(msg)
        if IsValid(This.entity) and run_on.ents[This.entity] then
            This.data.sockets[myID].error = 1
            This.data.sockets[myID].errormsg = msg
            This.entity:Execute()
            This.data.sockets[myID].error = nil
            This.data.sockets[myID].errormsg = nil
        end
    end

    socket:open()
end

e2function void wsCreateConnection( number id, string url, table headers )
    local myID = id
    local This = self
    self.data.sockets = self.data.sockets or {}

    if table.Count(self.data.sockets) > cvars.Number("wire_expression2_websocket_max", 3) or
       url == "" or
       self.data.sockets[myID] ~= nil then return end

    local socket = GWSockets.createWebSocket( url )

    for k, v in ipairs(headers) do
        socket:setHeader(k, v)
    end

    self.data.sockets[myID] = {
        socket=socket,
        url=url,
        headers=headers,
        cookies=cookies
    }

    function socket:onConnected()
        This.data.sockets[myID].isConnected = true
        if IsValid(This.entity) and run_on.ents[This.entity] then

            This.data.sockets[myID].connected = 1
            This.entity:Execute()
            This.data.sockets[myID].connected = nil
        end
    end

    function socket:onDisconnected()
        This.data.sockets[myID].isConnected = false

        if IsValid(This.entity) and run_on.ents[This.entity] then
            This.data.sockets[myID].disconnected = 1
            This.entity:Execute()
            This.data.sockets[myID].disconnected = nil
        end
    end

    function socket:onMessage(msg)
        if IsValid(This.entity) and run_on.ents[This.entity] then
            This.data.sockets[myID].data = 1
            This.data.sockets[myID].msg = msg
            This.entity:Execute()
            This.data.sockets[myID].data = nil
            This.data.sockets[myID].msg = nil
        end
    end

    function socket:onError(msg)
        if IsValid(This.entity) and run_on.ents[This.entity] then
            This.data.sockets[myID].error = 1
            This.data.sockets[myID].errormsg = msg
            This.entity:Execute()
            This.data.sockets[myID].error = nil
            This.data.sockets[myID].errormsg = nil
        end
    end

    socket:open()
end

e2function void wsCreateConnection( number id, string url, table headers, table cookies )
    local myID = id
    local This = self
    self.data.sockets = self.data.sockets or {}

    if table.Count(self.data.sockets) > cvars.Number("wire_expression2_websocket_max", 3) or
       url == "" or
       self.data.sockets[myID] ~= nil then return end

    local socket = GWSockets.createWebSocket( url )

    for k, v in ipairs(headers) do
        socket:setHeader(k, v)
    end

    for k, v in ipairs(cookies) do
        socket:setCookie(k, v)
    end

    self.data.sockets[myID] = {
        socket=socket,
        url=url,
        headers=headers,
        cookies=cookies
    }

    function socket:onConnected()
        This.data.sockets[myID].isConnected = true
        if IsValid(This.entity) and run_on.ents[This.entity] then

            This.data.sockets[myID].connected = 1
            This.entity:Execute()
            This.data.sockets[myID].connected = nil
        end
    end

    function socket:onDisconnected()
        This.data.sockets[myID].isConnected = false

        if IsValid(This.entity) and run_on.ents[This.entity] then
            This.data.sockets[myID].disconnected = 1
            This.entity:Execute()
            This.data.sockets[myID].disconnected = nil
        end
    end

    function socket:onMessage(msg)
        if IsValid(This.entity) and run_on.ents[This.entity] then
            This.data.sockets[myID].data = 1
            This.data.sockets[myID].msg = msg
            This.entity:Execute()
            This.data.sockets[myID].data = nil
            This.data.sockets[myID].msg = nil
        end
    end

    function socket:onError(msg)
        if IsValid(This.entity) and run_on.ents[This.entity] then
            This.data.sockets[myID].error = 1
            This.data.sockets[myID].errormsg = msg
            This.entity:Execute()
            This.data.sockets[myID].error = nil
            This.data.sockets[myID].errormsg = nil
        end
    end

    socket:open()
end

__e2setcost( 5 )
print("added wsCanCreate!")
e2function number wsCanCreate()
    self.data.sockets = self.data.sockets or {}
    return table.Count(self.data.sockets) < cvar_maxsockets and 1 or 0
end

print("added wsClkData!")
e2function number wsDataClk(number id)
    self.data.sockets = self.data.sockets or {}
    return self.data.sockets[id].data and 1 or 0
end

print("| wsClkConnect             |")
e2function number wsConnectClk(number id)
    self.data.sockets = self.data.sockets or {}
    return self.data.sockets[id].connected and 1 or 0
end

print("| wsClkDisconnect          |")
e2function number wsDisconnectClk(number id)
    self.data.sockets = self.data.sockets or {}
    return self.data.sockets[id].disconnected and 1 or 0
end

print("| wsClkError               |")
e2function string wsErrorClk(number id)
    self.data.sockets = self.data.sockets or {}
    return self.data.sockets[id].error or ""
end

print("| wsData                   |")
e2function string wsGetData(number id)
    self.data.sockets = self.data.sockets or {}
    return self.data.sockets[id].msg or ""
end

print("| wsURL                    |")
e2function string wsGetURL(number id)
    self.data.sockets = self.data.sockets or {}
    return self.data.sockets[id].url or ""
end

print("| wsError                  |")
e2function string wsGetError(number id)
    self.data.sockets = self.data.sockets or {}
    return self.data.sockets[id].errormsg or ""
end

e2function void wsClearMsgQueue(number id)
	self.data.sockets = self.data.sockets or {}
    if (!self.data.sockets[id].isConnected) then return end
	self.data.sockets[id].socket:clearQueue()
end

print("| wsSend                   |")
e2function void wsSend(number id, string data)
    self.data.sockets = self.data.sockets or {}
    if (!self.data.sockets[id].isConnected) then return end
    self.data.sockets[id].socket:write(data)
end

print("| wsClose                  |")
e2function void wsClose(number id)
    self.data.sockets = self.data.sockets or {}
    if (!self.data.sockets[id].isConnected) then return end
    self.data.sockets[id].socket:close()
	self.data.sockets[id] = nil
end
e2function void wsForceClose(number id)
    self.data.sockets = self.data.sockets or {}
    if (!self.data.sockets[id].isConnected) then return end
	self.data.sockets[id].socket:closeNow()
	self.data.sockets[id] = nil
end

print("| wsConnected              |")
e2function number wsIsConnected(number id)
    self.data.sockets = self.data.sockets or {}
    return self.data.sockets[id].isConnected and 1 or 0
end

print("| runOnWS                  |")
e2function void runOnWS(number shouldRun)
    run_on.ents[self.entity] = (shouldRun != 0) or nil
end

registerCallback( "destruct", function( self )
    self.data.sockets = self.data.sockets or {}
    for k, v in ipairs(self.data.sockets) do
        v.socket:closeNow()
    end
    run_on.ents[self.entity] = nil
end )

print("+--------------------------+")
print("| Finished loading.        |")
print("+--------------------------+")

