package util;

/**
 * Utilitário para escapar texto digitado pelo usuário antes de exibir na página
 * (evita que um nome como "<script>" seja interpretado como HTML).
 */
public class Html {

    public static String escapar(String texto) {
        if (texto == null) {
            return "";
        }
        return texto.replace("&", "&amp;")
                    .replace("<", "&lt;")
                    .replace(">", "&gt;")
                    .replace("\"", "&quot;")
                    .replace("'", "&#39;");
    }

}
