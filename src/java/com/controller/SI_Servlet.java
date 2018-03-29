package com.controller;

import com.DAO.CompteFacade;
import com.DAO.PublicationFacade;
import com.beans.Compte;
import java.io.IOException;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SI_Servlet
 */
public class SI_Servlet extends HttpServlet {

    @EJB
    private CompteFacade compteFacade;
    @EJB
    private PublicationFacade publicationFacade;
    private static final long serialVersionUID = 1L;

    public SI_Servlet() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        System.out.println("hh:::::::hh");
        String idCompte = request.getParameter("CIN");
        String MotDePasse = request.getParameter("Mot de passe");
        Compte compte = compteFacade.find(idCompte);
        if (compte != null && compte.getMotDePasse().equals(MotDePasse)) {

            request.login(idCompte, MotDePasse);
            request.getServletContext().log("Successfully logged in " + idCompte);

            System.out.println(request.isUserInRole("Utilisateur"));
            System.out.println(request.isUserInRole("Administrateur"));

            request.getSession().setAttribute("compte", compte);
            Compte compteAnonyme = new Compte();
            compteAnonyme.setNom("");
            compteAnonyme.setPrenom("Anonyme");
            request.getSession().setAttribute("compteAnonyme", compteAnonyme);
            response.sendRedirect("/");
            //request.getRequestDispatcher("/home.jsp").forward(request, response);
        } else {
            if (compte == null) {
                request.setAttribute("erreurCmpt", "Compte inexistant");
            } else {
                request.setAttribute("erreurMP", "Mot de passe incorrect");
            }
            request.getRequestDispatcher("/Signin.jsp").forward(request, response);
        }
    }
}
