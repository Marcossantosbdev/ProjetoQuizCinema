package util;

import java.util.Locale;

/** Formatação de percentuais para exibição e para uso em CSS. */
public class Formato {

    /** Texto para exibir ao usuário, no padrão brasileiro. Ex.: 62,5% */
    public static String percentual(double valor) {
        return String.format(Locale.forLanguageTag("pt-BR"), "%.1f%%", valor);
    }

    /** Número com ponto decimal para usar em style="width:..%" (vírgula quebraria o CSS). */
    public static String larguraCss(double valor) {
        return String.format(Locale.US, "%.1f", valor);
    }

}
