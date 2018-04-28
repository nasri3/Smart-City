package com.controller;

import com.DAO.*;
import com.beans.*;
import java.io.IOException;
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
    private NotificationDAO notificationDAO;

    @EJB
    private CommentaireDAO commentaireDAO;

    @EJB
    private CompteDAO compteDAO;

    @EJB
    private PublicationDAO publicationDAO;

    @EJB
    private EtablissementDAO etablissementDAO;
    
    @EJB
    private EvenementDAO evenementDAO;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        Compte compte = (Compte) request.getSession().getAttribute("compte");
        String uploadPath = getServletContext().getInitParameter("uploadPath");

        if (request.getParameter("SupprimerPP") != null) {
            if (!compte.getPhotoDeProfil().equals("avatar.png")) {
                Files.delete(Paths.get(uploadPath + compte.getPhotoDeProfil()));
                compte.setPhotoDeProfil("avatar.png");
                compteDAO.edit(compte);
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
                String FileType = itemFile.getContentType();
                // Process a regular form field
                if (!itemFile.isFormField()) {
                    String extension = (FileType.equals("image/svg+xml")) ? "svg" : FileType.substring(FileType.lastIndexOf("/") + 1);
                    String filename = compte.getPrenom() + compte.getNom() + RandomStringUtils.randomAlphanumeric(10) + "." + extension;
                    List imageAllowedTypes = Arrays.asList("image/jpeg", "image/gif", "image/png", "image/bmp", "image/svg+xml");
                    //upload le fichier
                    String res = UP_Servlet.saveFile(itemFile, imageAllowedTypes, 10485760, uploadPath + filename);
                    if (res.equals("succes")) {
                        if (!compte.getPhotoDeProfil().equals("avatar.png")) {
                            Files.delete(Paths.get(uploadPath + compte.getPhotoDeProfil()));
                        }
                        compte.setPhotoDeProfil(filename);
                        compteDAO.edit(compte);
                        request.getSession().setAttribute("compte", compte);
                    }
                    response.sendRedirect("/profil");
                    return;
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
        Compte compte = compteDAO.find(((Compte) request.getSession().getAttribute("compte")).getIdCompte());
        Publication publication;
        String idPub, idCompte;
        ArrayList<Publication> publications = new ArrayList();
        ArrayList<Publication> pubs = (ArrayList<Publication>) request.getSession().getAttribute("pubs");

        if (compte == null) {
            request.logout();
            request.getSession().invalidate();
            response.sendRedirect("/");
            return;
        } else {
            switch (compte.getType()) {
                case "Administrateur":
                    switch (operation) {
                        case "initialiserComptes":
                            request.getSession().setAttribute("comptes", compteDAO.findAll());
                            System.out.print(compteDAO.findAll().size());
                            break;
                        case "modifierType":
                            idCompte = request.getParameter("idCompte");
                            String type = request.getParameter("type");
                            Compte compte2 = compteDAO.find(idCompte);
                            if (compte2 == null) {
                                System.out.println("compte : " + idCompte + " non trouvé");
                                return;
                            }
                            compte2.setEtablissement(null);
                            compte2.setType(type);
                            compteDAO.edit(compte2);
                            break;
                        case "modifierSousAdministrateur":
                            idCompte = request.getParameter("idCompte");
                            String etablissement = request.getParameter("etablissement");
                            compte2 = compteDAO.find(idCompte);
                            if (compte2 == null) {
                                System.out.println("compte : " + idCompte + " non trouvé");
                                return;
                            }
                            Etablissement e = etablissementDAO.findByNom(etablissement);
                            compte2.setEtablissement(e);
                            compte2.setType("Sous administrateur");
                            compteDAO.edit(compte2);
                            return;
                        case "envoyerAlerte":
                            idCompte = request.getParameter("idCompte");
                            compte2 = compteDAO.find(idCompte);
                            if (compte2 == null) {
                                System.out.println("compte : " + idCompte + " non trouvé");
                                return;
                            } else {
                                System.out.println("compte : " + idCompte + " trouvé");
                            }
                            Notification notif = new Notification();
                            notif.setDestinataire(compte2);
                            notif.setExpediteur(compte);
                            notif.setTexte("Alerte");
                            notificationDAO.create(notif);
                            break;
                        case "supprimerPub":
                            idPub = request.getParameter("idPub");
                            publication = publicationDAO.find(idPub);
                            if (publication == null) {
                                System.out.println("pub" + idPub + " Not Found");
                                response.getWriter().write("pub" + idPub);
                                return;
                            }
                            publicationDAO.remove(publication);
                            String uploadPath = getServletContext().getInitParameter("uploadPath");
                            Files.delete(Paths.get(uploadPath + publication.getTitre()));
                            response.getWriter().write("pub" + idPub);
                            pubs.remove(publication);
                            request.getSession().setAttribute("pubs", pubs);
                            System.out.println(operation + " : pub" + idPub);
                            return;
                        case "supprimerCompte":
                            idCompte = request.getParameter("idCompte");
                            compteDAO.remove(compteDAO.find(idCompte));
                            break;
                    }
                case "Sous administrateur":
                    switch (operation) {
                        case "initialiserEtablissementPublications":
                            Etablissement e = compte.getEtablissement();
                            publications.addAll(publicationDAO.initialiserEtablissementPublications(e.getCategorie(), e.getVille()));
                            request.getSession().setAttribute("publications", publications);
                            request.getSession().setAttribute("pubs", publications);
                           
                            break;
                        case "marquerEtat":
                            idPub = request.getParameter("idPub");
                            String etat = request.getParameter("etat");
                            if (!Arrays.asList("résolu", "non résolu", "entrain de résolution").contains(etat)) {
                                System.out.println("état non valide");
                                return;
                            }
                            publication = publicationDAO.find(idPub);
                            publication.setEtat(etat);
                            Notification notif = new Notification();
                            notif.setExpediteur(compte);
                            notif.setTexte("<g>Un changement en état de publication suivis</g><br>"
                                    + "Publication : <a href='" + idPub + "'> </a><br>"
                                    + "Cette cas est maintenant" + etat);
                            publication.getCompteSuiviList().forEach(c -> {
                                notif.setDestinataire(c);
                                notificationDAO.create(notif);
                            });
                            publicationDAO.edit(publication);
                            break;
                    }
                case "Utilisateur":
                    switch (operation) {
                        case "ajouterPublications":
                            String titre = request.getParameter("titre");
                            idPub = request.getParameter("idPub");
                            if (titre.equals("Page d'accueil")) {
                                publications.addAll(publicationDAO.ajouterPublications(compte.getCategorie_interet(), compte.getGouvernorat_interet(), Integer.valueOf(idPub)));
                            } else if (titre.equals("Profil")) {
                                publications.addAll(publicationDAO.ajouterMesPublications(Integer.valueOf(idPub), compte));
                            } else {
                                Etablissement e = compte.getEtablissement();
                                publications.addAll(publicationDAO.ajouterEtablissementPublications(e.getCategorie(), e.getVille(), Integer.valueOf(idPub)));
                            }

                            request.getSession().setAttribute("publications", publications);

                            pubs.addAll(publications);
                            request.getSession().setAttribute("pubs", pubs);
                            break;
                        case "initialiserPublications":
                            publications.addAll(publicationDAO.initialiserPublications(compte.getCategorie_interet(), compte.getGouvernorat_interet()));
                            request.getSession().setAttribute("publications", publications);
                            request.getSession().setAttribute("pubs", publications);
                            request.getSession().setAttribute("evenements", evenementDAO.findAll());
                            System.out.println(evenementDAO.findAll().size());
                            break;
                        case "initialiserMesPublications":
                            publications.addAll(publicationDAO.initialiserMesPublications(compte));
                            request.getSession().setAttribute("publications", publications);
                            request.getSession().setAttribute("pubs", publications);
                            break;
                        case "raifraichirCommentaires":
                            idPub = request.getParameter("idPub");
                            int nbCom = Integer.valueOf(request.getParameter("nbCom"));
                            publication = publicationDAO.find(idPub);
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
                        case "raifraichirNotifications":
                            int nbNotif = compte.getNbreNotificationsNonVus();
                            request.getSession().setAttribute("nbNotif", nbNotif);
                            response.getWriter().write("" + nbNotif);
                            break;
                        case "setNotificationsVus":
                            compte.setNotificationsVus();
                            compteDAO.edit(compte);
                            request.getSession().setAttribute("nbNotif", 0);
                            System.out.println("okokoko");
                            break;
                        case "supprimerPub":
                            System.out.println("pub");
                            idPub = request.getParameter("idPub");
                            publication = publicationDAO.find(idPub);
                            if (publication == null) {
                                System.out.println("pub" + idPub + " Not Found");
                                response.getWriter().write("pub" + idPub);
                            } else if (compte.getIdCompte().equals(publication.getCompte().getIdCompte())) {
                                String uploadPath = getServletContext().getInitParameter("uploadPath");
                                Files.delete(Paths.get(uploadPath + publication.getTitre()));
                                publicationDAO.remove(publication);
                                response.getWriter().write("pub" + idPub);
                                pubs.remove(publication);
                                request.getSession().setAttribute("pubs", pubs);
                                System.out.println(operation + " : pub" + idPub);
                            }
                            break;
                        case "signalerPub":
                            idPub = request.getParameter("idPub");
                            publication = publicationDAO.find(idPub);
                            if (publication == null || compte.DejaSignaler(publication)) {
                                return;
                            }
                            compte.SignalerPublication(publication);
                            compteDAO.edit(compte);
                            
                            /*if(publication().size() == 3){
                            Notification n = new Notification();
                            n.setDestinataire(publication.getCompte());
                            n.setPublication(publication);
                            n.setTexte("Alerte : Attention, votre publication ");
                            }*/
                            
                            System.out.println(operation + " : " + idPub);
                            break;
                        case "suivrePub":
                            idPub = request.getParameter("idPub");
                            publication = publicationDAO.find(idPub);
                            if (publication == null || compte.DejaSuivi(publication)) {
                                return;
                            }
                            compte.SuivrePublication(publication);
                            compteDAO.edit(compte);
                            break;
                        case "commenter":
                            idPub = request.getParameter("idPub");
                            String text = request.getParameter("texte");
                            publication = publicationDAO.find(idPub);
                            if (publication == null || text == null) {
                                return;
                            }
                            Commentaire commentaire = new Commentaire();
                            commentaire.setCompte(compte);
                            commentaire.setPublication(publication);
                            commentaire.setTexte(text);
                            commentaireDAO.create(commentaire);
                            System.out.println(operation + " : " + idPub);
                            break;
                        case "modifierCatégorie":
                            String[] Categories = {"Agriculture", "Education", "Environnement", "Financière", "Infrastructure", "Santé",
                                "Sécurité", "Sport", "Tourisme", "Transport"};
                            String categorie = request.getParameter("catégorie");
                            if (!Arrays.asList(Categories).contains(categorie)) {
                                compte.setCategorie_interet("");
                            } else {
                                compte.setCategorie_interet(categorie);
                            }
                            compteDAO.edit(compte);
                            response.sendRedirect("/");
                            break;
                        case "modifierGouvernorat":
                            String[] Gouvernorats = {"Ariana", "Bèja", "Ben Arous", "Bizerte", "Gabès", "Gafsa", "Jendouba", "Kairouan", "Kasserine",
                                "Kébili", "Kef", "Mahdia", "Manouba", "Médenine", "Monastir", "Nabeul", "Sfax", "Sidi Bouzid", "Siliana",
                                "Sousse", "Tataouine", "Tozeur", "Tunis", "Zaghouan"};
                            String gouvernorat = request.getParameter("Gouvernorat");
                            if (!Arrays.asList(Gouvernorats).contains(gouvernorat)) {
                                compte.setGouvernorat_interet("");
                            } else {
                                compte.setGouvernorat_interet(gouvernorat);
                            }
                            compteDAO.edit(compte);
                            response.sendRedirect("/");
                            break;
                        case "getPublication":
                            idPub = request.getParameter("idPub");
                            publication = publicationDAO.find(idPub);
                            publications.add(publication);
                            request.getSession().setAttribute("publications", publications);
                            return;
                        case "deconnecter":
                            request.logout();
                            request.getSession().invalidate();
                            request.getServletContext().log("User successfully logged out logged out " + compte);
                            response.sendRedirect("/");
                            return;
                        case "supprimerMonCompte":
                            request.logout();
                            request.getSession().invalidate();
                            compteDAO.remove(compte);
                            response.sendRedirect("/");
                            return;
                        default:
                            response.sendRedirect("/");
                            return;
                    }
            }
        }
        request.getSession().setAttribute("compte", compte);
    }

}
