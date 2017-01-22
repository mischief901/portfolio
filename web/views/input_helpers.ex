defmodule Portfolio.InputHelpers do
  use Phoenix.HTML

  def input(form, field, opts \\ []) do
    type = opts[:using] || Phoenix.HTML.Form.input_type(form, field)

    wrapper_opts = [class: "form-group #{state_class(form, field)}"]
    label_opts = [class: "control-label"]
    input_opts = [class: "form-control"]
    validations = Phoenix.HTML.Form.input_validations(form, field)
    input_opts = Keyword.merge(validations, input_opts)

    content_tag :div do
      label = label(form, field, humanize(field), label_opts)
      input = input(type, form, field, input_opts)
      error = Portfolio.ErrorHelpers.error_tag(form, field)
      [label, input, error || ""]
    end
  end

  defp state_class(form, field) do
    cond do
      !form.source.action -> ""
      form.errors[field] -> "has-error"
      true -> "has-success"
    end
  end

  defp input(type, form, field, input_opts) do
    apply(Phoenix.HTML.Form, type, [form, field, input_opts])
  end

end