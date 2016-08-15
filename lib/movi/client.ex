defmodule Movi.Client do
    use GenServer
    require Logger
    alias Movi.Event

    def start_link() do
        GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
    end

    def add_handler(handler) do
        GenServer.call(__MODULE__, {:handler, handler})
    end

    def say(text) do
        GenServer.call(__MODULE__, {:say, text})
    end

    def threshold(percentage) do
        GenServer.call(__MODULE__, {:threshold, percentage})
    end

    def help do
        GenServer.call(__MODULE__, {:help})
    end

    def shutdown do
        GenServer.call(__MODULE__, {:shutdown})
    end

    def about do
        GenServer.call(__MODULE__, {:about})
    end

    def version do
        GenServer.call(__MODULE__, {:version})
    end

    def hwversion do
        GenServer.call(__MODULE__, {:hwversion})
    end

    def ping do
        GenServer.call(__MODULE__, {:ping})
    end

    def volume(percentage) do
        GenServer.call(__MODULE__, {:volume, percentage})
    end

    def stop do
        GenServer.call(__MODULE__, {:stop})
    end

    def restart do
        GenServer.call(__MODULE__, {:restart})
    end

    def factory do
        GenServer.call(__MODULE__, {:factory})
    end

    def password do
        GenServer.call(__MODULE__, {:password})
    end

    def female do
        GenServer.call(__MODULE__, {:female})
    end

    def male do
        GenServer.call(__MODULE__, {:male})
    end

    def vocabulary do
        GenServer.call(__MODULE__, {:vocabulary})
    end

    def callsign(callsign) do
        GenServer.call(__MODULE__, {:callsign, callsign})
    end

    def train do
        GenServer.call(__MODULE__, {:train})
    end

    def systemmessages(bool \\ "ON") do
        GenServer.call(__MODULE__, {:systemmessages, bool})
    end

    def responses(bool \\ "ON") do
        GenServer.call(__MODULE__, {:responses, bool})
    end

    def beeps(bool \\ "ON") do
        GenServer.call(__MODULE__, {:beeps, bool})
    end

    def welcomemessage(bool \\ "ON") do
        GenServer.call(__MODULE__, {:welcomemessage, bool})
    end

    def micdebug(bool \\ "ON") do
        GenServer.call(__MODULE__, {:micdebug, bool})
    end

    def init_board do
        GenServer.call(__MODULE__, {:init})
    end

    def newsentences do
        GenServer.call(__MODULE__, {:newsentences})
    end

    def addsentence(sentence) do
        GenServer.call(__MODULE__, {:addsentence, sentence})
    end

    def trainsentences do
        GenServer.call(__MODULE__, {:trainsentences})
    end

    def init(:ok) do
        tty = Application.get_env(:movi, :tty)
        speed = Application.get_env(:movi, :speed)
        {:ok, serial} = Serial.start_link([{:name, Movi.Serial}])
        {:ok, events} = GenEvent.start_link([{:name, Movi.Events}])
        Logger.debug "Starting Serial: #{tty}"
        Serial.open(Movi.Serial, tty)
        Logger.debug "Setting Speed: #{speed}"
        Serial.set_speed(Movi.Serial, speed)
        Logger.debug "Connecting..."
        Serial.connect(Movi.Serial)
        Logger.info "Running"
        {:ok, %{:message => "", :events => events, :handlers => []}}
    end

    def handle_call({:say, text}, _from, state) do
        Serial.send_data(Movi.Serial, "SAY #{text}\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:threshold, percentage}, _from, state) do
        Serial.send_data(Movi.Serial, "THRESHOLD #{percentage}\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:help}, _from, state) do
        Serial.send_data(Movi.Serial, "HELP\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:shutdown}, _from, state) do
        Serial.send_data(Movi.Serial, "SHUTDOWN\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:about}, _from, state) do
        Serial.send_data(Movi.Serial, "ABOUT\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:version}, _from, state) do
        Serial.send_data(Movi.Serial, "VERSION\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:hwversion}, _from, state) do
        Serial.send_data(Movi.Serial, "HWVERSION\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:ping}, _from, state) do
        Serial.send_data(Movi.Serial, "PING\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:volume, percentage}, _from, state) do
        Serial.send_data(Movi.Serial, "VOLUME #{percentage}\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:stop}, _from, state) do
        Serial.send_data(Movi.Serial, "STOP\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:restart}, _from, state) do
        Serial.send_data(Movi.Serial, "RESTART\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:factory}, _from, state) do
        Serial.send_data(Movi.Serial, "FACTORY\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:password}, _from, state) do
        Serial.send_data(Movi.Serial, "PASSWORD\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:female}, _from, state) do
        Serial.send_data(Movi.Serial, "FEMALE\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:male}, _from, state) do
        Serial.send_data(Movi.Serial, "MALE\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:vocabulary}, _from, state) do
        Serial.send_data(Movi.Serial, "VOCABULARY\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:callsign, callsign}, _from, state) do
        Serial.send_data(Movi.Serial, "CALLSIGN #{callsign}\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:train}, _from, state) do
        Serial.send_data(Movi.Serial, "TRAIN\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:systemmessages, bool}, _from, state) do
        Serial.send_data(Movi.Serial, "SYSTEMMESSAGES #{bool}\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:responses, bool}, _from, state) do
        Serial.send_data(Movi.Serial, "RESPONSES #{bool}\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:beeps, bool}, _from, state) do
        Serial.send_data(Movi.Serial, "BEEPS #{bool}\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:welcomemessage, bool}, _from, state) do
        Serial.send_data(Movi.Serial, "WELCOMEMESSAGE #{bool}\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:micdebug, bool}, _from, state) do
        Serial.send_data(Movi.Serial, "MICDEBUG #{bool}\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:init}, _from, state) do
        Serial.send_data(Movi.Serial, "INIT\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:newsentences}, _from, state) do
        Serial.send_data(Movi.Serial, "NEWSENTENCES\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:addsentence, sentence}, _from, state) do
        Serial.send_data(Movi.Serial, "ADDSENTENCE #{sentence}\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:trainsentences}, _from, state) do
        Serial.send_data(Movi.Serial, "TRAINSENTENCES\r\n")
        {:reply, :ok, state}
    end

    def handle_call({:handler, handler}, {pid, _} = from, state) do
        GenEvent.add_mon_handler(state.events, handler, pid)
        {:reply, :ok, %{state | :handlers => [{handler, pid} | state.handlers]}}
    end

    def handle_info({:gen_event_EXIT, handler, reason}, state) do
        Enum.each(state.handlers, fn(h) ->
            GenEvent.add_mon_handler(state.events, elem(h, 0), elem(h, 1))
        end)
        {:noreply, state}
    end

    def handle_info({:elixir_serial, _serial, data}, state) do
        new_state = %{state | :message => state.message <> data}
        case String.ends_with?(new_state.message, ["\n", "\r"]) do
            true ->
                case ev = create_event(new_state.message) do
                    %Event{} ->
                        GenEvent.notify(state.events, ev)
                        new_state = %{new_state | :message => ""}
                    nil ->
                        new_state = %{new_state | :message => ""}
                end
            _ ->
                :ok
        end
        {:noreply, new_state}
    end

    defp create_event(message) do
        event = Regex.named_captures(~r"\[(?<code>\d+)\]: (?<message>.+)$", String.strip(message))
        case event["message"] do
            nil -> nil
            _ -> %Event{:code => case Integer.parse(event["code"]) do
                    :error -> event["code"]
                    {int, rem} -> int
                end, :message => String.split(event["message"])}
        end
    end
end