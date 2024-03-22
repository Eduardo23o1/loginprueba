import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:loguinprueba/WelcomeView.dart';
import 'package:loguinprueba/config/color_schemes.g.dart';
import 'package:loguinprueba/config/sizes.dart';
import 'package:loguinprueba/extensions/keyboard.dart';
import 'package:loguinprueba/widgets/text_field_widget.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey;
  final ScrollController _scrollController;
  final TextEditingController _emailController;
  final TextEditingController _passwordController;
  final TextEditingController _firstNameController;
  final TextEditingController _documentController;
  final TextEditingController _lastNameController;
  final TextEditingController _telephoneController;
  final TextEditingController _userTypeController;
  final FocusNode _focusNode = FocusNode();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool visibilityPassword = false;
  bool remember = false;
  bool isRegister = false;
  bool isProcessing = false;

  _LoginViewState()
      : _emailController = TextEditingController(),
        _passwordController = TextEditingController(),
        _documentController = TextEditingController(),
        _firstNameController = TextEditingController(),
        _lastNameController = TextEditingController(),
        _telephoneController = TextEditingController(),
        _userTypeController = TextEditingController(),
        _scrollController = ScrollController(),
        _formKey = GlobalKey<FormState>();

  void toggleVisibilityPassword() {
    setState(() {
      visibilityPassword = !visibilityPassword;
    });
  }

  void toggleRemember() {
    setState(() {
      remember = !remember;
    });
  }

  void toggleRegister() {
    setState(() {
      isRegister = !isRegister;
    });
  }

  void setIsProcessing(bool value) {
    setState(() {
      isProcessing = value;
    });
  }

  Future onRegister(BuildContext context) async {
    setIsProcessing(true);
  }

  void clearControllers() {
    var controllers = [
      _emailController,
      _passwordController,
      _documentController,
      _firstNameController,
      _lastNameController,
      _telephoneController,
      _userTypeController,
    ];

    for (var controller in controllers) {
      controller.clear();
    }
  }

  Future<UserCredential?> signInWithGoogle() async {
    try {
      // Solicitar la autenticación de Google
      final GoogleSignInAccount? googleSignInAccount =
          await _googleSignIn.signIn();

      // Obtener las credenciales de acceso a Google
      final GoogleSignInAuthentication? googleSignInAuthentication =
          await googleSignInAccount?.authentication;

      // Crear una credencial de autenticación con Google
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication?.accessToken,
        idToken: googleSignInAuthentication?.idToken,
      );

      // Iniciar sesión con la credencial en Firebase
      final UserCredential authResult =
          await _auth.signInWithCredential(credential);

      // Retornar el resultado de la autenticación
      return authResult;
    } catch (error) {
      // Manejar cualquier error que ocurra durante el proceso
      print("Error al iniciar sesión con Google: $error");
      return null;
    }
  }

  /* Widget _loginWithGoogleButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
          UserCredential? userCredential = await signInWithGoogle();
          if (userCredential != null) {
            // El usuario ha iniciado sesión exitosamente, realiza las acciones necesarias
          } else {
            // Hubo un error durante el inicio de sesión, muestra un mensaje de error al usuario
          }
        },
        child: Text("Iniciar sesión con Google"),
      ),
    );
  }*/

  Widget _loginWithGoogleButton() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: () async {
          UserCredential? userCredential = await signInWithGoogle();
          if (userCredential != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => WelcomeView()),
            );
          } else {
            // Hubo un error durante el inicio de sesión, muestra un mensaje de error al usuario
          }
        },
        icon: SvgPicture.asset(
          'assets/google.svg', // Ruta de acceso al archivo SVG en tu carpeta de activos
          height: 24, // Tamaño del icono (ajusta según sea necesario)
          width: 24,
        ),
        label: Text(
            isRegister ? "Registrate con Google" : "Inicia sesión con Google"),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(
              Color.fromARGB(255, 255, 255, 255)), // Color de fondo del botón
          foregroundColor: MaterialStateProperty.all(
              const Color.fromARGB(255, 0, 0, 0)), // Color del texto del botón
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10), // Borde redondeado del botón
          )),
        ),
      ),
    );
  }

  Widget _headerSection(BuildContext context) {
    return Container(
      color: const Color(0xffC9FFBD),
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Container(
            height: 80,
            // margin: const EdgeInsets.only(left: 10, right: 10),
            // decoration: BoxDecoration(
            //     border: Border.all(style: BorderStyle.solid)
            // ),
            /* child: SvgPicture.asset(
                'assets/carpa2.svg', // Ruta de acceso al archivo SVG en tu carpeta de activos
                height: 50, // Tamaño del icono (ajusta según sea necesario)
                width: 50,
                alignment: Alignment.center), */
          ),
          _titleHeader(),
          Container(
            height: 80,
            margin:
                const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            /* decoration:
                BoxDecoration(border: Border.all(style: BorderStyle.solid)), */
            /* child: SvgPicture.asset(
                'assets/carpa2.svg', // Ruta de acceso al archivo SVG en tu carpeta de activos
                height: 50, // Tamaño del icono (ajusta según sea necesario)
                width: 50,
                alignment: Alignment.center), */
          ),

          // _titleApp(color: darkColorScheme.secondary, margin: const EdgeInsets.only(top: 20)),
        ],
      ),
    );
  }

  Widget _titleHeader() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: const Text("Login",
          style: TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.w500,
            color: Color(0xff479442),
          )),
    );
  }

  Widget _titleSign() {
    return Text(isRegister ? "Registrarse" : "Iniciar Sesión",
        style: const TextStyle(
          fontSize: Sizes.titleH1,
          fontWeight: FontWeight.w500,
          color: const Color(0xff479442),
        ));
  }

  Widget _inputUserEmail() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: TextFieldWidget(
          hintText: 'Correo electrónico',
          prefixIcon: Icons.mail,
          textInputType: TextInputType.emailAddress,
          validator: MultiValidator([
            RequiredValidator(errorText: 'El email es requerido'),
            EmailValidator(errorText: 'Ingrese una dirección de correo valida')
          ]),
          controller: _emailController,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          focusNode: _focusNode,
        ));
  }

  Widget _inputPassword() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: TextFieldWidget(
          hintText: 'Contraseña',
          prefixIcon: Icons.password,
          autoValidateMode: AutovalidateMode.onUserInteraction,
          suffixIcon:
              visibilityPassword ? Icons.visibility_off : Icons.visibility,
          obscureText: !visibilityPassword,
          onPressedSuffixIcon: toggleVisibilityPassword,
          validator: MultiValidator([
            RequiredValidator(errorText: 'La contraseña es requerida'),
            if (isRegister) ...[
              PatternValidator('[a-z]+',
                  errorText: 'Al menos un letra minúscula'),
              PatternValidator('[A-Z]+',
                  errorText: 'Al menos un letra mayúscula'),
              PatternValidator('[0-9]+', errorText: 'Al menos un número'),
              MinLengthValidator(6, errorText: 'Mínimo 6 caracteres'),
              MaxLengthValidator(8, errorText: 'Maximo 8 caracteres')
            ]
          ]),
          controller: _passwordController,
        ));
  }

  Widget _inputDocument() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: TextFieldWidget(
          hintText: 'Documento',
          prefixIcon: Icons.short_text,
          validator: MultiValidator([
            RequiredValidator(errorText: 'El documento es requerido'),
          ]),
          controller: _documentController,
          textInputType: TextInputType.number,
        ));
  }

  Widget _inputFirstName() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: TextFieldWidget(
          hintText: 'Nombres',
          prefixIcon: Icons.short_text,
          validator: MultiValidator([
            RequiredValidator(errorText: 'El primer nombre es requerido'),
            MaxLengthValidator(30, errorText: 'Maximo 30 caracteres')
          ]),
          controller: _firstNameController,
        ));
  }

  Widget _inputLastName() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: TextFieldWidget(
          hintText: 'Apellidos',
          prefixIcon: Icons.short_text,
          controller: _lastNameController,
          validator: MultiValidator([
            RequiredValidator(errorText: 'El segundo nombre es requerido'),
            MaxLengthValidator(30, errorText: 'Maximo 30 caracteres')
          ]),
        ));
  }

  Widget _inputTelephone() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: TextFieldWidget(
          hintText: 'Teléfono',
          prefixIcon: Icons.phone,
          textInputType: TextInputType.phone,
          validator: MultiValidator([
            RequiredValidator(errorText: 'El teléfono es requerido'),
            MaxLengthValidator(10, errorText: 'Maximo 10 dígitos')
          ]),
          controller: _telephoneController,
        ));
  }

  Widget _rememberSection() {
    return Container(
        margin: const EdgeInsets.only(top: 10),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Flexible(
              child: Checkbox(
                value: remember,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                fillColor: MaterialStateProperty.all(remember
                    ? const Color(0xff1E6D20)
                    : const Color(0xff9fec93)),
                // activeColor: Color(0xff9fec93),
                side: const BorderSide(
                    style: BorderStyle.solid, color: Color(0xff1E6D20)),
                checkColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                onChanged: (value) => toggleRemember(),
              ),
            ),
            Expanded(
              flex: 4,
              child: GestureDetector(
                onTap: toggleRemember,
                child: const Text('Remember me',
                    style: TextStyle(
                      fontSize: Sizes.hint,
                      color: Color(0xff1E6D20),
                    )),
              ),
            ),
            const Expanded(
              flex: 4,
              child: Text('Forgot password?',
                  textAlign: TextAlign.end,
                  style: TextStyle(
                      fontSize: Sizes.hint, color: Color(0xff1E6D20))),
            )
          ],
        ));
  }

  Widget _buttonLogin() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => onRegister(context),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(const Color(0xff479442)),
            foregroundColor:
                MaterialStateProperty.all(lightColorScheme.inverseSurface),
            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)))),
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Text(isRegister ? 'Registrarse' : 'Iniciar Sesión',
                style: const TextStyle(
                    fontSize: Sizes.button,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                    color: Colors.white))),
      ),
    );
  }

  Widget _registerToggle() {
    return Container(
        margin: const EdgeInsets.only(top: 15),
        child: GestureDetector(
          child: RichText(
              text: TextSpan(children: [
            TextSpan(
                text: isRegister
                    ? "¿Ya estás registrado? "
                    : "¿No estás registrado?  ",
                style: const TextStyle(
                    fontSize: Sizes.hint,
                    color: Color(0xff479442),
                    fontWeight: FontWeight.w500)),
            TextSpan(
                text: isRegister ? "Inicia sesión" : "Registrate ahora",
                style: const TextStyle(
                    fontSize: Sizes.hint + 1,
                    color: Color(0xff479442),
                    fontWeight: FontWeight.w900))
          ])),
          onTap: () => toggleRegister(),
        ));
  }

  Widget _signSection() {
    return Container(
      decoration: BoxDecoration(
          // border: Border.all(style: BorderStyle.solid, width: 5, color: lightColorScheme.secondary),
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(0), topRight: Radius.circular(100)),
          color: const Color(0xfff6f8e5),
          boxShadow: [
            BoxShadow(
                color: const Color(0xff1E6D20).withOpacity(0.1),
                blurRadius: 1,
                spreadRadius: 2,
                offset: const Offset(0, -1))
          ]),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
      // margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Center(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: Container(
            constraints: const BoxConstraints(maxWidth: 500),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Flexible(child: _titleSign()),
                _inputUserEmail(),
                _inputPassword(),
                if (isRegister) ...[
                  _inputDocument(),
                  _inputFirstName(),
                  _inputLastName(),
                  _inputTelephone(),
                ],
                // Expanded(child: Container()),
                if (isProcessing)
                  Container(
                    margin: const EdgeInsets.only(top: 30),
                    /* child: const CircularProgress(
                      size: 30,
                      color: Palette.primary,
                    ), */
                  )
                else ...[
                  _buttonLogin(),
                  Flexible(child: _registerToggle()),
                  _loginWithGoogleButton(),
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget mainWidget(BuildContext context) {
    var mediaQuery = MediaQuery.of(context).size;
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          context.downKeyboard();
        },
        child: Container(
            constraints: BoxConstraints(
              minWidth: mediaQuery.width,
              minHeight: mediaQuery.height,
            ),
            child: LayoutBuilder(
                builder: (context, constraint) => Container(
                      child: SingleChildScrollView(
                        controller: _scrollController,
                        padding: EdgeInsets.zero,
                        child: Container(
                          color: const Color(0xffC9FFBD),
                          constraints: BoxConstraints(
                            minWidth: constraint.maxWidth,
                            minHeight: constraint.maxHeight,
                          ),
                          child: IntrinsicHeight(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _headerSection(context),
                                Flexible(child: _signSection()),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xffC9FFBD),
        appBar: AppBar(
          backgroundColor: const Color(0xfff6f8e5),
          elevation: 0,
          toolbarHeight: 0,
        ),
        body: mainWidget(context));
  }

  @override
  void initState() {
    super.initState();
  }
}
