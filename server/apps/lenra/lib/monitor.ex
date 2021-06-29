defmodule Lenra.Monitor do
  @moduledoc """
  This module is monitoring requests at different places

  Lenra's monitor executes the following events:

  * `[:lenra, :openfaas_action, :start]` - Executed before an openfaas action.

    #### Measurements

      * No need for any measurement.

    #### Metadata

      * No need for any metadata.

  * `[:lenra, :openfaas_action, :stop]` - Executed after an openfaas action.

    #### Measurements

      * `:duration` - The time took by the openfaas action in `:native` unit of time.

    #### Metadata

      * `:user_id` - The id of the user who executed the action.
      * `:application_name` - The name of the application from which the action was executed.

  """

  alias Lenra.{OpenfaasRunActionMeasurementServices, ClientAppMeasurementServices}

  def setup do
    events = [
      [:lenra, :openfaas_runaction, :stop],
      [:lenra, :client_app_channel, :stop]
    ]

    :telemetry.attach_many("lenra.monitor", events, &Lenra.Monitor.handle_event/4, nil)
  end

  def handle_event([:lenra, :openfaas_runaction, :stop], measurements, metadata, _config) do
    %{user_id: user_id, application_name: application_name} = metadata
    %{duration: duration} = measurements

    OpenfaasRunActionMeasurementServices.create(
      user_id,
      %{application_name: application_name, duration: System.convert_time_unit(duration, :native, :nanosecond)}
    )
  end

  def handle_event([:lenra, :client_app_channel, :stop], measurements, metadata, _config) do
    duration = System.convert_time_unit(measurements.duration, :native, :nanosecond)

    ClientAppMeasurementServices.create(metadata.user_id, %{
      application_name: metadata.application_name,
      duration: duration
    })
  end

  def handle_event(_, _measurements, _metadata, _config) do
  end
end
