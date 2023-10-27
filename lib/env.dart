enum Env { DEV, PROD }

class EnvConfig {
  static Env? envBuild;
  
  static String urlConfig() {
    switch (envBuild) {
      case Env.DEV:
        return "http://192.168.0.105/ws/exotica/";
      case Env.PROD:
        return "https://exoticaoficial.com.br/adm/ws/api/";
      default:
        return "";
    }
  }
}
