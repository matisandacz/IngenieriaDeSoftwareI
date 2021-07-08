A continuación se muestra el código necesario para crear una instanccia de la cara externa de la interfaz REST. 

server := TusLibrosRestInterface listeningOn: 9092.
server startListening.
LoginWindow open.

Asegurarse de que la clase TusLibrosClient en la categoría TusLibros-GUI devuelve el puerto que se está utilizando en el mensaje 'port'.

Al momento de iniciar sesión, se nos pedirá un nombre de usuario y contraseña válidos. 

El siguiente usuario contiene una tarjeta de crédito válida.

clientId: validUser
password: validUserPassword

El siguiente usuario contiene una tarjeta de crédito expirada.

clientId: expiredUser
password: expiredUserPassword

La siguiente pantalla a la de Login será una donde podemos visualizar el catalogo (isbn junto a titulo) y seleccionar la cantidad de items a comprar.
Para agregar al carrito y para elimnar hay dos botones debidamente identificados para lograrlo.

Luego podemos ir a visualizar en esta pantalla, nuestras compras ya hechas.
O sino podemos ir a hacer el checkout, viendo antes el carrito asegurandonos que es lo que tenemos.

Luego podemos hacer el checkout propiamente dicho, y visualizaremos el ticket de la compra.
Para finalizar se puede desloguear o seguir comprando.
