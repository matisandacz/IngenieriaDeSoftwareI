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
