import 'package:flutter/material.dart'; // Importa el paquete de Flutter para crear aplicaciones móviles.
import 'dart:math'; // Importa el paquete de matemáticas para generar números aleatorios.
import 'dart:async'; // Importa el paquete de temporizadores.
import 'package:shared_preferences/shared_preferences.dart'; // Importa el paquete para almacenar datos en el dispositivo.
import 'dart:ui'; // Importa el paquete de interfaz de usuario.

void main() {
  runApp(MyApp()); // Ejecuta la aplicación principal.
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Constructor de la clase MyApp.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Color App', // Título de la aplicación.
      theme: ThemeData(
        primarySwatch: Colors.blue, // Tema principal de la aplicación.
      ),
      home: HomePage(), // Página inicial de la aplicación.
    );
  }
}

// PAGINA PRINCIPAL
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color App'), // Título en la barra de la aplicación.
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/img_1.png'), // Imagen de fondo.
                fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el fondo.
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Aplica un desenfoque a la imagen de fondo.
            child: Container(
              color: Colors.black.withOpacity(0.2), // Aplica un color negro semi-transparente.
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido verticalmente.
              children: [
                Image.asset(
                  'assets/img/img.png', // Imagen en el centro de la pantalla.
                  width: 250, // Ancho de la imagen.
                  height: 250, // Alto de la imagen.
                ),
                SizedBox(height: 50), // Espacio vertical.
                SizedBox(
                  width: 280, // Ancho del botón.
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => StroopTestPage()), // Navega a la página del test de Stroop.
                      );
                    },
                    child: Text('Iniciar Juego'), // Texto del botón.
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54, // Fondo oscuro del botón.
                      foregroundColor: Colors.purpleAccent, // Color del texto del botón.
                      minimumSize: Size(0, 50), // Tamaño mínimo del botón.
                    ),
                  ),
                ),
                SizedBox(height: 10), // Espacio vertical.
                SizedBox(
                  width: 280, // Ancho del botón.
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SettingsPage()), // Navega a la página de configuración.
                      );
                    },
                    child: Text('Configuración Personalizada'), // Texto del botón.
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54, // Fondo oscuro del botón.
                      foregroundColor: Colors.purpleAccent, // Color del texto del botón.
                      minimumSize: Size(0, 50), // Tamaño mínimo del botón.
                    ),
                  ),
                ),
                SizedBox(height: 10), // Espacio vertical.
                SizedBox(
                  width: 280, // Ancho del botón.
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HighScoresPage()), // Navega a la página de puntajes altos.
                      );
                    },
                    child: Text('Puntajes Más Altos'), // Texto del botón.
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black54, // Fondo oscuro del botón.
                      foregroundColor: Colors.purpleAccent, // Color del texto del botón.
                      minimumSize: Size(0, 50), // Tamaño mínimo del botón.
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState(); // Crea el estado de la página de configuración.
}

class _SettingsPageState extends State<SettingsPage> {
  late SharedPreferences _prefs; // Variable para almacenar preferencias.
  late bool _limitByTime; // Variable para limitar el tiempo.
  late int _displayDuration; // Duración de la presentación de cada palabra.
  late int _attempts; // Número de intentos.

  @override
  void initState() {
    super.initState();
    _loadSettings(); // Carga las configuraciones al iniciar.
  }

  Future<void> _loadSettings() async {
    _prefs = await SharedPreferences.getInstance(); // Obtiene la instancia de SharedPreferences.
    setState(() {
      _limitByTime = _prefs.getBool('limitByTime') ?? false; // Carga la configuración de limitar por tiempo.
      _displayDuration = _prefs.getInt('displayDuration') ?? 3000; // Carga la duración de la presentación.
      _attempts = _prefs.getInt('attempts') ?? 3; // Carga el número de intentos.
    });
  }

  Future<void> _saveSettings() async {
    await _prefs.setBool('limitByTime', _limitByTime); // Guarda la configuración de limitar por tiempo.
    await _prefs.setInt('displayDuration', _displayDuration); // Guarda la duración de la presentación.
    await _prefs.setInt('attempts', _attempts); // Guarda el número de intentos.
  }

  // CONFIGURACION PERSONALIZADA
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Configuración'), // Título en la barra de la aplicación.
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/img_1.png'), // Imagen de fondo.
                fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el fondo.
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Aplica un desenfoque a la imagen de fondo.
            child: Container(
              color: Colors.black.withOpacity(0.2), // Aplica un color negro semi-transparente.
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 30.0), // Padding horizontal.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Alinea el contenido al inicio horizontalmente.
                mainAxisSize: MainAxisSize.min, // Minimiza el tamaño vertical.
                children: [
                  SwitchListTile(
                    title: Text('Limitar por tiempo'), // Título del switch.
                    value: _limitByTime, // Valor del switch.
                    onChanged: (bool value) {
                      setState(() {
                        _limitByTime = value; // Cambia el valor del switch.
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Duración de presentación de cada palabra'), // Título del campo.
                    trailing: SizedBox(
                      width: 100, // Ancho del campo de texto.
                      child: TextField(
                        keyboardType: TextInputType.number, // Tipo de teclado.
                        onChanged: (value) {
                          _displayDuration = int.tryParse(value) ?? 5000; // Cambia la duración de la presentación.
                        },
                        decoration: InputDecoration(
                          hintText: _displayDuration.toString(), // Texto de ayuda.
                        ),
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Número de intentos'), // Título del campo.
                    trailing: SizedBox(
                      width: 100, // Ancho del campo de texto.
                      child: TextField(
                        keyboardType: TextInputType.number, // Tipo de teclado.
                        onChanged: (value) {
                          _attempts = int.tryParse(value) ?? 3; // Cambia el número de intentos.
                        },
                        decoration: InputDecoration(
                          hintText: _attempts.toString(), // Texto de ayuda.
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20), // Espacio vertical.
                  Center(
                    child: SizedBox(
                      width: 200, // Ancho del botón.
                      child: ElevatedButton(
                        onPressed: () async {
                          await _saveSettings(); // Guarda las configuraciones.
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Configuración guardada')), // Muestra un mensaje.
                          );
                        },
                        child: Text('Guardar Configuración'), // Texto del botón.
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54, // Fondo oscuro del botón.
                          foregroundColor: Colors.purpleAccent, // Color del texto del botón.
                          minimumSize: Size(0, 50), // Tamaño mínimo del botón.
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// INICIAR JUEGO
class StroopTestPage extends StatefulWidget {
  @override
  _StroopTestPageState createState() => _StroopTestPageState(); // Crea el estado de la página del test de Stroop.
}

class _StroopTestPageState extends State<StroopTestPage> {
  final List<String> _colors = ['Rojo', 'Verde', 'Azul', 'Amarillo']; // Lista de colores.
  final List<Color> _colorValues = [Colors.red, Colors.green, Colors.blue, Colors.yellow]; // Lista de valores de colores.
  final Random _random = Random(); // Generador de números aleatorios.
  String _displayedColor = ''; // Color mostrado.
  Color _displayedTextColor = Colors.black; // Color del texto mostrado.
  int _score = 0; // Puntuación del jugador.
  int _attempts = 3; // Número de intentos.
  int _correctAnswers = 0; // Número de respuestas correctas.
  int _totalWordsDisplayed = 0; // Número total de palabras mostradas.
  bool _isTestRunning = false; // Indica si el test está en curso.
  bool _isPaused = false; // Indica si el test está en pausa.
  late Stopwatch _stopwatch; // Cronómetro.
  late Timer _timer; // Temporizador.
  int _displayDuration = 3000; // Duración de la presentación de cada palabra.
  int _pauseCount = 0; // Número de pausas.
  String _reactionTime = ''; // Tiempo de reacción.

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch(); // Inicializa el cronómetro.
    _loadScore(); // Carga la puntuación.
    _loadSettings(); // Carga las configuraciones.
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance(); // Obtiene la instancia de SharedPreferences.
    setState(() {
      _displayDuration = prefs.getInt('displayDuration') ?? 3000; // Carga la duración de la presentación.
      _attempts = prefs.getInt('attempts') ?? 3; // Carga el número de intentos.
    });
  }

  void _startTest() {
    setState(() {
      _isTestRunning = true; // Indica que el test está en curso.
      _score = 0; // Reinicia la puntuación.
      _attempts = 3; // Reinicia el número de intentos.
      _correctAnswers = 0; // Reinicia el número de respuestas correctas.
      _totalWordsDisplayed = 0; // Reinicia el número total de palabras mostradas.
      _pauseCount = 0; // Reinicia el número de pausas.
    });
    _showNextColor(); // Muestra el siguiente color.
  }

  void _showNextColor() {
    if (!_isTestRunning) return; // Si el test no está en curso, no hace nada.

    setState(() {
      _displayedColor = _colors[_random.nextInt(_colors.length)]; // Muestra un color aleatorio.
      _displayedTextColor = _colorValues[_random.nextInt(_colorValues.length)]; // Muestra un valor de color aleatorio.
    });
    _stopwatch.reset(); // Reinicia el cronómetro.
    _stopwatch.start(); // Inicia el cronómetro.
    _totalWordsDisplayed++; // Incrementa el número total de palabras mostradas.

    _timer = Timer(Duration(milliseconds: _displayDuration), () {
      if (_stopwatch.isRunning) {
        _checkAnswer(null); // Si el cronómetro está en curso, verifica la respuesta.
      }
    });
  }

  void _checkAnswer(String? color) {
    if (!_isTestRunning) return; // Si el test no está en curso, no hace nada.

    _stopwatch.stop(); // Detiene el cronómetro.
    _reactionTime = _stopwatch.elapsedMilliseconds.toString() + ' ms'; // Guarda el tiempo de reacción.

    if (color != null && _displayedTextColor == _colorValues[_colors.indexOf(color)]) {
      _correctAnswers++; // Incrementa el número de respuestas correctas.
      _score++; // Incrementa la puntuación.
    } else {
      _attempts--; // Decrementa el número de intentos.
    }

    if (_attempts <= 0) {
      _endTest(); // Si no hay más intentos, finaliza el test.
    } else {
      _showNextColor(); // Muestra el siguiente color.
    }

    _saveScore(_score, _reactionTime); // Guarda la puntuación.
  }

  void _pauseTest() {
    if (_pauseCount < 2) {
      setState(() {
        _isPaused = !_isPaused; // Alterna el estado de pausa.
        if (_isPaused) {
          _stopwatch.stop(); // Detiene el cronómetro.
          _timer.cancel(); // Cancela el temporizador.
        } else {
          _showNextColor(); // Muestra el siguiente color.
          _pauseCount++; // Incrementa el número de pausas.
        }
      });
    }
  }

  void _endTest() {
    setState(() {
      _isTestRunning = false; // Indica que el test no está en curso.
      _timer.cancel(); // Cancela el temporizador.
    });

    _saveHighScore(); // Asegúrate de llamar a _saveHighScore() antes de mostrar el diálogo

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Resultado del Juego'), // Título del diálogo.
          content: Text('Palabras correctas: $_correctAnswers\nIntentos restantes: $_attempts\nTotal de palabras mostradas: $_totalWordsDisplayed'), // Contenido del diálogo.
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo.
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HighScoresPage()), // Navega a la página de puntajes altos.
                );
              },
              child: Text('Ver Puntajes Más Altos'), // Texto del botón.
            ),
          ],
        );
      },
    );
  }

  Future<void> _saveHighScore() async {
    final prefs = await SharedPreferences.getInstance(); // Obtiene la instancia de SharedPreferences.
    List<String> highScores = prefs.getStringList('highScores') ?? []; // Carga la lista de puntajes altos.
    highScores.add('Puntuación: $_score, Tiempo de reacción: $_reactionTime'); // Agrega la nueva puntuación.
    if (highScores.length > 5) {
      highScores.sort((a, b) {
        int scoreA = int.parse(a.split(',')[0].split(': ')[1]);
        int scoreB = int.parse(b.split(',')[0].split(': ')[1]);
        return scoreB.compareTo(scoreA); // Ordena la lista de puntajes altos.
      });
      highScores = highScores.sublist(0, 5); // Mantiene solo los 5 mejores puntajes.
    }
    await prefs.setStringList('highScores', highScores); // Guarda la lista de puntajes altos.
  }

  Future<void> _saveScore(int score, String reactionTime) async {
    final prefs = await SharedPreferences.getInstance(); // Obtiene la instancia de SharedPreferences.
    prefs.setInt('lastScore', score); // Guarda la última puntuación.
    prefs.setString('lastReactionTime', reactionTime); // Guarda el último tiempo de reacción.
  }

  Future<void> _loadScore() async {
    final prefs = await SharedPreferences.getInstance(); // Obtiene la instancia de SharedPreferences.
    setState(() {
      _score = prefs.getInt('lastScore') ?? 0; // Carga la última puntuación.
      _reactionTime = prefs.getString('lastReactionTime') ?? ''; // Carga el último tiempo de reacción.
    });
  }

  Widget _buildButton(String color) {
    return ElevatedButton(
      onPressed: () => _checkAnswer(color), // Verifica la respuesta al hacer clic en el botón.
      child: Text(
        color, // Texto del botón.
        style: TextStyle(
          color: Colors.white, // Color del texto del botón.
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: _colorValues[_colors.indexOf(color)], // Fondo del botón.
        minimumSize: Size(120, 50), // Tamaño mínimo del botón.
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stroop Test App'), // Título en la barra de la aplicación.
        actions: [
          if (_isTestRunning)
            IconButton(
              icon: Icon(Icons.pause), // Icono de pausa.
              onPressed: _pauseTest, // Pausa el test al hacer clic en el icono.
            ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/img/img_1.png'), // Imagen de fondo.
                fit: BoxFit.cover, // Ajusta la imagen para cubrir todo el fondo.
              ),
            ),
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Aplica un filtro de desenfoque.
            child: Container(
              color: Colors.black.withOpacity(0.2), // Ajusta la opacidad según lo necesites.
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (!_isTestRunning)
                  ElevatedButton(
                    onPressed: _startTest, // Inicia el test al hacer clic en el botón.
                    child: Text('Iniciar Test'), // Texto del botón.
                  ),
                if (_isTestRunning)
                  Column(
                    children: [
                      Text(
                        _displayedColor, // Muestra el color.
                        style: TextStyle(
                          fontSize: 50, // Tamaño de fuente del color.
                          color: _displayedTextColor, // Color del texto.
                        ),
                      ),
                      SizedBox(height: 20), // Espaciado entre elementos.
                      Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildButton('Rojo'), // Botón para el color rojo.
                              SizedBox(width: 10), // Espaciado entre botones.
                              _buildButton('Verde'), // Botón para el color verde.
                            ],
                          ),
                          SizedBox(height: 10), // Espaciado entre filas.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildButton('Azul'), // Botón para el color azul.
                              SizedBox(width: 10), // Espaciado entre botones.
                              _buildButton('Amarillo'), // Botón para el color amarillo.
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 20), // Espaciado entre elementos.
                      Text('Puntuación: $_score'), // Muestra la puntuación.
                      Text('Palabras correctas: $_correctAnswers'), // Muestra el número de palabras correctas.
                      Text('Total de palabras mostradas: $_totalWordsDisplayed'), // Muestra el total de palabras mostradas.
                      Text('Intentos restantes: $_attempts'), // Muestra el número de intentos restantes.
                      Text('Tiempo de reacción: $_reactionTime'), // Muestra el tiempo de reacción.
                    ],
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// PUNTUACIONES MÁS ALTAS
class HighScoresPage extends StatefulWidget {
  @override
  _HighScoresPageState createState() => _HighScoresPageState(); // Crea el estado de la página de puntajes más altos.
}

class _HighScoresPageState extends State<HighScoresPage> {
  late SharedPreferences _prefs; // Instancia de SharedPreferences.
  List<String> _highScores = []; // Lista de puntajes altos.

  @override
  void initState() {
    super.initState();
    _loadHighScores(); // Carga los puntajes más altos.
  }

  Future<void> _loadHighScores() async {
    _prefs = await SharedPreferences.getInstance(); // Obtiene la instancia de SharedPreferences.
    setState(() {
      _highScores = _prefs.getStringList('highScores') ?? []; // Carga la lista de puntajes altos.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Puntajes Más Altos'), // Título en la barra de la aplicación.
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0), // Padding alrededor de la lista.
        child: ListView.builder(
          itemCount: _highScores.length, // Número de elementos en la lista.
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(_highScores[index]), // Texto del puntaje alto.
            );
          },
        ),
      ),
    );
  }
}
