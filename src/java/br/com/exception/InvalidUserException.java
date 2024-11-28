package br.com.exception;

import jakarta.servlet.ServletException;

/**
 * Exceção personalizada para indicar que o usuário é inválido.
 */
public class InvalidUserException extends ServletException {

    /**
     * Construtor que aceita uma mensagem de erro.
     *
     * @param message Mensagem de erro.
     */
    public InvalidUserException(String message) {
        super(message);
    }

    /**
     * Construtor que aceita uma mensagem de erro e uma exceção subjacente.
     *
     * @param message Mensagem de erro.
     * @param cause Exceção que causou esta exceção.
     */
    public InvalidUserException(String message, Throwable cause) {
        super(message, cause);
    }
}
