package com.controller;

import com.DAO.*;
import com.beans.*;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Iterator;
import java.util.List;
import java.util.Objects;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.ejb.EJB;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.lang.RandomStringUtils;
import org.apache.tomcat.util.http.fileupload.FileItem;
import org.apache.tomcat.util.http.fileupload.FileUploadException;
import org.apache.tomcat.util.http.fileupload.disk.DiskFileItemFactory;
import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;
import org.apache.tomcat.util.http.fileupload.servlet.ServletRequestContext;

public class CTRL_Servlet extends HttpServlet {

    @EJB
    private CommentaireFacade commentaireFacade;

    @EJB
    private CompteFacade compteFacade;

    @EJB
    private PublicationFacade publicationFacade;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        List imageAllowedTypes = Arrays.asList("image/jpeg", "image/gif", "image/png", "image/bmp", "image/svg+xml");
        Compte compte = (Compte) request.getSession().getAttribute("compte");
        String uploadPath = getServletContext().getInitParameter("uploadPath");

        if (request.getParameter("SupprimerPP") != null) {
            if (!compte.getPhotoDeProfil().equals("avatar.png")) {
                Files.delete(Paths.get(uploadPath + compte.getPhotoDeProfil()));
                compte.setPhotoDeProfil("avatar.png");
                compteFacade.edit(compte);
                request.getSession().setAttribute("compte", compte);
            }
            response.sendRedirect("/profil");
            return;
        }

        // Create a new file upload handler
        DiskFileItemFactory factory = new DiskFileItemFactory();
        ServletFileUpload upload = new ServletFileUpload(factory);

        // on recupère tous les champs du formulaire
        List itemlist;
        try {
            itemlist = upload.parseRequest(new ServletRequestContext(request));
            // Process the uploaded items
            Iterator iter = itemlist.iterator();

            while (iter.hasNext()) {
                FileItem itemFile = (FileItem) iter.next();
                // Process a regular form field
                if (!itemFile.isFormField()) {
                    long FileSize = itemFile.getSize();
                    if (FileSize != 0 && FileSize < 10000000 && imageAllowedTypes.contains(itemFile.getContentType())) {
                        System.out.println("Fichier valide");

                        //upload the file
                        String extension = itemFile.getName().substring(itemFile.getName().lastIndexOf(".")).toLowerCase();
                        String filename = "PP/" + compte.getPrenom() + compte.getNom() + RandomStringUtils.randomAlphanumeric(10) + extension;

                        InputStream stream = itemFile.getInputStream();
                        FileOutputStream fout = new FileOutputStream(uploadPath + filename);
                        BufferedInputStream bin;
                        try (BufferedOutputStream bout = new BufferedOutputStream(fout)) {
                            bin = new BufferedInputStream(stream);
                            byte buf[] = new byte[4096];
                            while ((bin.read(buf)) != -1) {
                                bout.write(buf);
                            }
                        }
                        bin.close();
                        if (!compte.getPhotoDeProfil().equals("avatar.png")) {
                            Files.delete(Paths.get(uploadPath + compte.getPhotoDeProfil()));
                        }
                        compte.setPhotoDeProfil(filename);
                        compteFacade.edit(compte);
                        request.getSession().setAttribute("compte", compte);
                        response.sendRedirect("/profil");
                        return;

                    } else {
                        System.out.println("Fichier non valide");
                        response.sendRedirect("/profil");
                        return;
                    }
                }
            }
        } catch (FileUploadException ex) {
            Logger.getLogger(UP_Servlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operation = request.getParameter("operation");
        Compte compte = (Compte) request.getSession().getAttribute("compte");
        Publication publication;
        String idPub, idCompte;
        ArrayList<Publication> publications = new ArrayList();
        ArrayList<Publication> pubs = (ArrayList<Publication>) request.getSession().getAttribute("pubs");

        switch (compte.getRole()) {
            case "Administrateur":
                switch (operation) {
                    /*
                    case "envoyerAlerte":
                        idCompte = request.getParameter("idCompte");
                        idPub = request.getParameter("idPub");
                        break;*/
                    case "supprimerPub":
                        idPub = request.getParameter("idPub");
                        publication = publicationFacade.find(idPub);
                        if (publication == null) {
                            System.out.println("pub" + idPub + " Not Found");
                            response.getWriter().write("pub" + idPub);
                            return;
                        }
                        String uploadPath = getServletContext().getInitParameter("uploadPath");
                        Files.delete(Paths.get(uploadPath + publication.getTitre()));
                        publicationFacade.remove(publication);
                        response.getWriter().write("pub" + idPub);
                        pubs.remove(publication);
                        request.getSession().setAttribute("pubs", pubs);
                        System.out.println(operation + " : pub" + idPub);
                        break;
                    case "supprimerCompte":
                        idCompte = request.getParameter("idCompte");
                        compteFacade.remove(compteFacade.find(idCompte));
                        response.sendRedirect("/");
                        break;
                }
            case "Sous administrateur":
                switch (operation) {
                    case "marquerEtat":
                        idPub = request.getParameter("idPub");
                        String etat = request.getParameter("etat");
                        if (!Arrays.asList("résolu", "non résolu", "entrain de résolution").contains(etat)) {
                            System.out.println("etat non valide");
                            response.sendRedirect("/");
                            return;
                        }
                        publication = publicationFacade.find(idPub);
                        publication.setEtat(etat);
                        publicationFacade.edit(publication);
                        break;
                }
            case "Utilisateur":
                switch (operation) {
                    case "ajouterPublications":
                        String titre = request.getParameter("titre");
                        idPub = request.getParameter("idPub");
                        System.out.println(titre + " " + idPub);
                        if (titre.equals("Page d'accueil")) {
                            publications.addAll(publicationFacade.ajouterPublications(Integer.valueOf(idPub), compte));
                        } else {
                            publications.addAll(publicationFacade.ajouterVosPublications(Integer.valueOf(idPub), compte));
                        }
                        request.getSession().setAttribute("publications", publications);

                        pubs.addAll(publications);
                        request.getSession().setAttribute("pubs", pubs);
                        break;
                    case "initialiserPublications":
                        publications.addAll(publicationFacade.initialiserPublications(compte));
                        request.getSession().setAttribute("publications", publications);
                        request.getSession().setAttribute("pubs", publications);
                        break;
                    case "initialiserVosPublications":
                        publications.addAll(publicationFacade.initialiserVosPublications(compte));
                        request.getSession().setAttribute("publications", publications);
                        request.getSession().setAttribute("pubs", publications);
                        break;
                    case "raifraichirCommentaires":
                        idPub = request.getParameter("idPub");
                        int nbCom = Integer.valueOf(request.getParameter("nbCom"));
                        publication = publicationFacade.find(idPub);
                        if (publication != null && publication.getCommentaireList().size() != nbCom) {
                            for (int i = 0; i < pubs.size(); i++) {
                                if (Objects.equals(pubs.get(i).getIdPublication(), Integer.valueOf(idPub))) {
                                    pubs.set(i, publication);
                                    response.getWriter().write(i + "");
                                    break;
                                }
                            }
                        } else {
                            response.getWriter().write("-1");
                        }
                        break;
                    case "supprimerPub":
                        System.out.println("pub");
                        idPub = request.getParameter("idPub");
                        publication = publicationFacade.find(idPub);
                        if (publication == null) {
                            System.out.println("pub" + idPub + " Not Found");
                            response.getWriter().write("pub" + idPub);
                        } else if (compte.getIdCompte().equals(publication.getCompte().getIdCompte())) {
                            String uploadPath = getServletContext().getInitParameter("uploadPath");
                            Files.delete(Paths.get(uploadPath + publication.getTitre()));
                            publicationFacade.remove(publication);
                            response.getWriter().write("pub" + idPub);
                            pubs.remove(publication);
                            request.getSession().setAttribute("pubs", pubs);
                            System.out.println(operation + " : pub" + idPub);
                        }
                        break;
                    case "signalerPub":
                        idPub = request.getParameter("idPub");
                        publication = publicationFacade.find(idPub);
                        if (publication == null || compte.DejaSignaler(publication)) {
                            return;
                        }
                        compte.SignalerPublication(publication);
                        compteFacade.edit(compte);
                        request.getSession().setAttribute("compte", compte);
                        System.out.println(operation + " : " + idPub);
                        break;
                    case "commenter":
                        idPub = request.getParameter("idPub");
                        String text = request.getParameter("texte");
                        publication = publicationFacade.find(idPub);
                        if (publication == null || text == null) {
                            return;
                        }
                        Commentaire commentaire = new Commentaire();
                        commentaire.setCompte(compte);
                        commentaire.setPublication(publication);
                        commentaire.setTexte(text);
                        commentaireFacade.create(commentaire);
                        System.out.println(operation + " : " + idPub);
                        break;
                    case "toggleCatégorie":
                        String catégorie = request.getParameter("catégorie");
                        String catégorieinteret = compte.getCatégorieinteret();
                        if(!catégorieinteret.contains(catégorie))
                            compte.setCatégorieinteret(catégorieinteret + "," + catégorie);
                        else compte.setCatégorieinteret(catégorieinteret.replace("," + catégorie, ""));
                        compteFacade.edit(compte);
                        request.getSession().setAttribute("compte", compte);
                        break;
                    case "toggleVille":
                        String ville = request.getParameter("ville");
                        String villeinteret = compte.getVilleinteret();
                        if(!villeinteret.contains(ville))
                            compte.setVilleinteret(villeinteret + "," + ville);
                        else compte.setVilleinteret(villeinteret.replace("," + ville, ""));
                        compteFacade.edit(compte);
                        request.getSession().setAttribute("compte", compte);
                        break;
                    case "deconnecter":
                        request.logout();
                        request.getSession().invalidate();
                        request.getServletContext().log("User successfully logged out logged out " + compte);
                        response.sendRedirect("/");
                        break;
                    case "supprimerMonCompte":
                        request.logout();
                        request.getSession().invalidate();
                        compteFacade.remove(compte);
                        response.sendRedirect("/");
                        break;
                    default:
                        response.sendRedirect("/");
                        break;
                }
        }
    }

}
