{% extends 'layouts/template.volt' %}

{% block content %}
  <ul>
  	{% for todo in todos %}
      <li>
        <h4>{{ todo.title }} ({{ todo.getId() }})</h4>
        <div>
          <ul>
            {% for todo_item in todo.getItems() %}
              <li>{{ todo_item.title }}</li>
            {% endfor %}
            <li>
              <form action="todo/add_item" method="post">
                <input type="text" name="todo_title" />
                <input type="hidden" name="todo_id" value="{{ todo.getId() }}" />
                <input type="submit" value="add" />
              </form>
            </li>
          </ul>
        </div>
      </li>
    {% endfor %}
  </ul>
{% endblock %}
