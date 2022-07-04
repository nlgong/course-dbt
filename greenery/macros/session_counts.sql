{%- macro session_counts(column_name) %}
   count(distinct case when {{column_name}} = 1 then session_id else null end)::integer as {{column_name}}_counts
{% endmacro -%}