package com.controller;

import com.DAO.CompteDAO;
import com.beans.Compte;
import static com.controller.Reg_Servlet.cryptWithMD5;
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
    private CompteDAO compteDAO;
    private static final long serialVersionUID = 1L;

    public SI_Servlet() {
        super();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String CIN = request.getParameter("CIN");
        String MotDePasse = cryptWithMD5(request.getParameter("Mot de passe"));
        Compte compte = compteDAO.find(CIN);
        if (compte != null && compte.getMotDePasse().equals(MotDePasse)) {
            SeConnecter(request, response, CIN, MotDePasse);
            request.getSession().setAttribute("compte", compte);
            response.sendRedirect("/");
        } else {
            if (compte == null) {
                request.setAttribute("erreurCmpt", "Compte inexistant");
            } else {
                request.setAttribute("erreurMP", "Mot de passe incorrect");
            }
            request.getRequestDispatcher("/Signin.jsp").forward(request, response);
        }
    }

    public static void SeConnecter(HttpServletRequest request, HttpServletResponse response, String IdCompte, String MotDePasse) throws ServletException {
        request.login(IdCompte, MotDePasse);
        request.getServletContext().log("Successfully logged in " + IdCompte);

        Compte compteAnonyme = new Compte();
        compteAnonyme.setNom("");
        compteAnonyme.setPrenom("Anonyme");
        request.getSession().setAttribute("compteAnonyme", compteAnonyme);
        String[] Gouvernorats = {"Tous", "Ariana", "Bèja", "Ben Arous", "Bizerte", "Gabès", "Gafsa", "Jendouba", "Kairouan", "Kasserine", 
            "Kébili", "Kef", "Mahdia", "Manouba", "Médenine", "Monastir", "Nabeul", "Sfax", "Sidi Bouzid", "Siliana", 
            "Sousse", "Tataouine", "Tozeur", "Tunis", "Zaghouan"};
        String[] Categories = {"Tous", "Agriculture", "Education", "Environnement", "Financière", "Infrastructure", "Santé", 
            "Sécurité", "Sport", "Tourisme", "Transport"};
        request.getSession().setAttribute("Gouvernorats", Gouvernorats);
        request.getSession().setAttribute("Catégories", Categories);
    }
}
