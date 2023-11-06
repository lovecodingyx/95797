{% macro to_boolean(column_name) %}

(case
	when {{column_name}} = 'Y' then true
	when {{column_name}} = 'N' then false
	when {{column_name}} = ' ' then null
	when {{column_name}} is null then null
	else {{column_name}}
end)::bool

{% endmacro %}
