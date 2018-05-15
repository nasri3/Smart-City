/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.DAO;

import com.beans.Compte;
import com.beans.Publication;
import java.util.Arrays;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

@Stateless
public class PublicationDAO extends AbstractDAO<Publication> {

    @PersistenceContext(unitName = "PCDPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public PublicationDAO() {
        super(Publication.class);
    }

    public List<Publication> initialiserPublications(String categorie, String gouvernorat) {
        List categories = Arrays.asList(categorie.split(","));
        if (categorie.equals("Tous")) {
            if (gouvernorat.equals("Tous")) {
                return getEntityManager().createNamedQuery("Publication.findAll").setMaxResults(5).getResultList();
            }
            return getEntityManager().createNamedQuery("Publication.findbyGouvernorat")
                    .setParameter("gouvernorat", gouvernorat)
                    .setMaxResults(5).getResultList();
        }
        if (gouvernorat.equals("Tous")) {
            return getEntityManager().createNamedQuery("Publication.findbyCategorie")
                    .setParameter("categories", categories)
                    .setMaxResults(5).getResultList();
        }
        return getEntityManager().createNamedQuery("Publication.findbyCategorieGouvernorat")
                .setParameter("categories", categories)
                .setParameter("gouvernorat", gouvernorat)
                .setMaxResults(5).getResultList();
    }

    public List<Publication> initialiserMesPublications(Compte compte) {
        return getEntityManager().createNamedQuery("Publication.findbyCompte")
                .setParameter("compte", compte)
                .setMaxResults(5).getResultList();
    }

    public List<Publication> ajouterPublications(String categorie, String gouvernorat, int idDerniere) {
        List categories = Arrays.asList(categorie.split(","));
        if (categorie.equals("Tous")) {
            if (gouvernorat.equals("Tous")) {
                return getEntityManager().createNamedQuery("Publication.findAllAfterId")
                        .setParameter("idDerniere", idDerniere)
                        .setMaxResults(3).getResultList();
            }
            return getEntityManager().createNamedQuery("Publication.findbyGouvernoratAfterId")
                    .setParameter("gouvernorat", gouvernorat)
                    .setParameter("idDerniere", idDerniere)
                    .setMaxResults(3).getResultList();
        }
        if (gouvernorat.equals("Tous")) {
            return getEntityManager().createNamedQuery("Publication.findbyCategorieAfterId")
                    .setParameter("categories", categories)
                    .setParameter("idDerniere", idDerniere)
                    .setMaxResults(3).getResultList();
        }
        return getEntityManager().createNamedQuery("Publication.findbyCategorieGouvernoratAfterId")
                .setParameter("categories", categories)
                .setParameter("gouvernorat", gouvernorat)
                .setParameter("idDerniere", idDerniere)
                .setMaxResults(3).getResultList();
    }

    public List<Publication> ajouterMesPublications(int idDerniere, Compte compte) {
        return getEntityManager().createNamedQuery("Publication.findbyCompteAfterId")
                .setParameter("compte", compte)
                .setParameter("idDerniere", idDerniere).setMaxResults(3).getResultList();
    }

    public List<Publication> initialiserEtablissementPublications(String categorie, String ville) {
        if(ville.contains("Governorat")){
            return this.initialiserPublications(categorie, ville.replace("Gouvernorat ", ""));
        }
        List categories = Arrays.asList(categorie.split(","));
        return getEntityManager().createNamedQuery("Publication.findbyCategorieVille")
                .setParameter("categories", categories)
                .setParameter("ville", ville)
                .setMaxResults(5).getResultList();
    }

    public List<Publication> ajouterEtablissementPublications(String categorie, String ville, int idDerniere) {
        if(ville.contains("Governorat")){
            return this.ajouterPublications(categorie, ville.replace("Gouvernorat ", ""), idDerniere);
        }List categories = Arrays.asList(categorie.split(","));
        return getEntityManager().createNamedQuery("Publication.findbyCategorieVilleAfterId")
                .setParameter("categories", categories)
                .setParameter("ville", ville)
                .setParameter("idDerniere", idDerniere)
                .setMaxResults(3).getResultList();    
    }
    
    public long nombreDeSignalisations(Publication publication){
        return  (long) getEntityManager().createNamedQuery("Publication.nbreComptesSignales")
                .setParameter("publication", publication)
                .getSingleResult();
    }

}
