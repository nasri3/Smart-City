package com.controller;

import com.DAO.*;
import com.beans.*;
import java.io.IOException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Date;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Servlet
 */
public class Reg_Servlet extends HttpServlet {

    @EJB
    private CompteFacade compteFacade;
    @EJB
    private PublicationFacade publicationFacade;

    private static final long serialVersionUID = 1L;

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     */
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub

        // 1. Get Parameters from JSP Page
        String IdCompte = request.getParameter("CIN");
        String Nom = request.getParameter("Nom");
        String Prenom = request.getParameter("Prenom");
        String DateDeNaissance = request.getParameter("DateDeNaissance");
        if(request.getParameter("g-recaptcha-response")==null || request.getParameter("g-recaptcha-response").isEmpty())
            return;
        
        DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        Date DateNaissance = null;
        try {
            DateNaissance = new Date(formatter.parse(DateDeNaissance).getTime());
        } catch (ParseException ex1) {
            Logger.getLogger(Reg_Servlet.class.getName()).log(Level.SEVERE, null, ex1);
        }
        String Ville = request.getParameter("Ville");
        String MotDePasse1 = request.getParameter("MotDePasse1");
        String MotDePasse2 = request.getParameter("MotDePasse2");
        if (!MotDePasse1.equals(MotDePasse2)) {
            request.setAttribute("erreurMP", "Mot De Passe non conforme");
            request.getRequestDispatcher("/Register").forward(request, response);
            return;
        }
        if (compteFacade.find(IdCompte) != null) {
            request.setAttribute("erreurCmpt", "Compte existant");
            request.getRequestDispatcher("/Register").forward(request, response);
            return;
        }

        //2. Creation d'un nouvel compte
        Compte compte = new Compte();
        compte.setIdCompte(IdCompte);
        compte.setNom(Nom);
        compte.setPrenom(Prenom);
        compte.setDateDeNaissance(DateNaissance);
        compte.setMotDePasse(cryptWithMD5(MotDePasse1));
        compte.setVille(Ville);
        System.out.println(IdCompte + " " + Nom + " " + Prenom + " " + DateDeNaissance + " " + cryptWithMD5(MotDePasse1) + " " + Ville);
        //3.Inserer la compte dans la BD
        compteFacade.create(compte);
        System.out.println("role : " + compte.getRole());
        request.login(IdCompte, cryptWithMD5(MotDePasse1));

        request.getSession().setAttribute("compte", compte);
        Compte compteAnonyme = new Compte();
        compteAnonyme.setNom("");
        compteAnonyme.setPrenom("Anonyme");
        request.getSession().setAttribute("compteAnonyme", compteAnonyme);
        // Positionner le content type
        response.sendRedirect("/");
        //response.setContentType("image/jpg");

        // DaoMVC.affiche();
        //request.getRequestDispatcher("/home.jsp").forward(request, response);
    }

    //MD5 Cryptage
    private static MessageDigest md;

    public static String cryptWithMD5(String pass) {
        try {
            md = MessageDigest.getInstance("MD5");
            byte[] passBytes = pass.getBytes();
            md.reset();
            byte[] digested = md.digest(passBytes);
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < digested.length; i++) {
                sb.append(Integer.toHexString(0xff & digested[i]));
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException ex) {
            Logger.getLogger(Reg_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        return null;
    }
}
