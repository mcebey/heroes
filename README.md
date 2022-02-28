# heroes

Se usa una arquitectura MVVM. 

Para los test se autogenera el código con mockolo.
Para la inyección de dependencias se usa Resolver.


El directorio de carpetas contiene lo siguiente: 

 - Utils: Clases de utilidad general dentro del proyecto
 - Models: Los modelos que usarán la vistas
 - Interactors: Los casos de uso
 - Data :
    - DataSourceModels : Son los modelos que exponen los datasource
    - DataSource: capa de acceso a los datos que abstrae del lugar donde se encuentran
    - ServiceModels: Los modelos del servicio, en este caso un api
    - Service: Capa de acceso a los servicios (Api, BBDD, sockets...)
- DI: Configuración de la inyección de dependencias
- UI: Capa de las vista (viewcontroller + viewmodel)
- Config: Configuración de la app


## Notas: 

- Siguiente un poco el modelo de redux de ReactJS, los viewmodel usan acciones y estados los cuales nos permiten tanto testear como asentar las vistas, ya que las acciones modifican los estados, y la vista solo puede estar en un estado al mismo tiempo.

- He creado una clase Binding emulando una micro arquitectura reactiva, ya que creo que favorece la lectura del código.

- La parte del conexion si bien es sencillo permite ver como con una simple capa, podemos abstraer los problemas del cliente usando por parte del api, pudiendo cambiar a Alamofire sin necesidad de tocar otra parte del código.

- Se han incluido un par de test, para mostrar como se hace el uso de la inversión del control para poder realizarlos de una forma mucho más simple.

- Las librerias externas se han incluido usando Swift Package Manager

- Se ha agregado una excepción en el App Transport Security que permita solo el dominio de las images que se descargan


## Consideraciones a tener en cuenta: 

 - Si el numero de pantallas creciese, sería bueno usar un router por cada una de las páginas, pero en este caso es tan sencillo que no aplica. 
 
 - La parte del dominio se podría separar en una libreria perfectamente sin apenas verse afectada la aplicación. 
 
 - Con MVVM si nos cambiasemos a SwiftUI podríamos hacer de una forma fácil compatible casi todo el código usado
 
 - En un futuro podríamos necesitar la inclusión de una capa manager si tuviesemos varios origines de datos de donde elegir
