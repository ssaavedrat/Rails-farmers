# Proyecto "Granjas y Granjeros"

Este proyecto se enfoca en desarrollar una aplicación en Ruby on Rails que maneje la relación entre granjas y granjeros, junto con la gestión de animales asociados a los granjeros. A través de este ejercicio guiado, aprenderás a configurar las relaciones, trabajar con formularios anidados y aplicar eliminaciones en cascada en tu aplicación.

## Pasos

### Paso 1: Crear el Proyecto

```bash
rails new farmers -d postgresql
```

### Paso 2: Crear la Base de Datos

```bash
rails db:create
```

### Paso 3: Generar el Modelo Farmer

```bash
rails g model Farmer name age
```

### Paso 4: Generar el Modelo Animal y Scaffold

```bash
rails g scaffold Animal name
```

### Paso 5: Agregar Relaciones a los Modelos

En `app/models/animal.rb`:

```ruby
class Animal < ApplicationRecord
  belongs_to :farmer
end
```

En `app/models/farmer.rb`:

```ruby
class Farmer < ApplicationRecord
  has_many :animals, dependent: :destroy
end
```

### Paso 6: Seleccionar Ruta Raíz

En `config/routes.rb`:

```ruby
Rails.application.routes.draw do
  root "animals#index"
end
```

### Paso 7: Crear Migración Manual para Agregar `farm_id` a Animals

```bash
rails g migration AddFarmToAnimals farm:references
```

### Paso 8: Agregar Modelo Farm con Scaffold

```bash
rails g scaffold Farm name
```

### Paso 9: Relacionar Models Farm y Farmer

En `app/models/farmer.rb`:

```ruby
belongs_to :farm
```

En `app/models/farm.rb`:

```ruby
class Farm < ApplicationRecord
  has_many :farmers, dependent: :destroy
  accepts_nested_attributes_for :farmers, allow_destroy: true
end
```

### Paso 10: Modificar Formulario de Farms para Enviar Datos de Farmers

En `app/views/farms/_form.html.erb`:

```erb
<h3>Granjeros</h3>
<div>
  <%= form.fields_for :farmers do |farmer| %>
    <%= farmer.label :name, style: "display: block" %>
    <%= farmer.text_field :name %>
    <%= farmer.label :age, style: "display: block" %>
    <%= farmer.text_field :age %>
    <br>
    <%= farmer.check_box :_destroy %>
    <%= farmer.label :_destroy, "Borrar" %>
  <% end %>
</div>
```

### Paso 11: Modificar strong_params de Farms

En `app/controllers/farms_controller.rb`:

```ruby
def farm_params
  params.require(:farm).permit(:name, farmers_attributes: [:id, :name, :age, :_destroy])
end
```

### Paso 12: Agregar Granjeros al Método `new`

En `app/controllers/farms_controller.rb`:

```ruby
def new
  @farm = Farm.new
  @farm.farmers.build
end
```

### Paso 13: Mostrar los Granjeros de Cada Granja en el Index de Farms

En `app/views/farms/_farm.html.erb`:

```erb
<div id="<%= dom_id farm %>">
  <div>
    <p>
      <strong>Name:</strong>
      <%= farm.name %>
      <strong>Granjeros</strong>
      <% farm.farmers.each do |farmer| %>
        <span><%= farmer.name %> </span>
      <% end %>
      <span>
        <%= link_to "Show this farm", farm %> |
        <%= button_to "Destroy this farm", farm, method: :delete %>
      </span>
    </p>
  </div>
</div>
```

### Paso 14: Eliminación de Registros en Cascada

En `app/models/farm.rb`:

```ruby
class Farm < ApplicationRecord
  has_many :farmers, dependent: :destroy
end
```

En `app/models/farmer.rb`:

```ruby
class Farmer < ApplicationRecord
  has_many :animals, dependent: :destroy
  belongs_to :farm
  def to_s
    self.name
  end
end
```

### Paso 15: Eliminar una Granja

- Presiona el botón en la vista show de una granja para eliminarla, comprobando que elimina en cascada su granjero y animales asociados.
