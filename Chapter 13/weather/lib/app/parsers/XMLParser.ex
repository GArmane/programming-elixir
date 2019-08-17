defmodule Weather.App.Parsers.XMLParser do
  import SweetXml

  def parse(doc, mapping) do
    doc
    |> xmap(mapping)
  end
end
