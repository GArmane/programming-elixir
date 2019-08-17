defmodule Weather.App.Parsers.XMLParser do
  alias Weather.Domain.Entities.NOAAObservation

  import SweetXml

  def parse(doc) do
    doc
    |> xmap(NOAAObservation.xml_mapping)
  end
end
