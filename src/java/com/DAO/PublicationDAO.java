/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.DAO;

import com.beans.Compte;
import com.beans.Publication;
import java.util.Collection;
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
        if (categorie.isEmpty()) {
            if (gouvernorat.isEmpty()) {
                return getEntityManager().createNamedQuery("Publication.findAll").setMaxResults(5).getResultList();
            }
            return getEntityManager().createNamedQuery("Publication.findbyGouvernorat")
                    .setParameter("gouvernorat", gouvernorat)
                    .setMaxResults(5).getResultList();
        }
        if (gouvernorat.isEmpty()) {
            return getEntityManager().createNamedQuery("Publication.findbyCategorie")
                    .setParameter("categorie", categorie)
                    .setMaxResults(5).getResultList();
        }
        return getEntityManager().createNamedQuery("Publication.findbyCategorieGouvernorat")
                .setParameter("categorie", categorie)
                .setParameter("gouvernorat", gouvernorat)
                .setMaxResults(5).getResultList();
    }

    public List<Publication> initialiserMesPublications(Compte compte) {
        return getEntityManager().createNamedQuery("Publication.findbyCompte")
                .setParameter("compte", compte)
                .setMaxResults(5).getResultList();
    }

    public List<Publication> ajouterPublications(String categorie, String gouvernorat, int idDerniere) {
        if (categorie.isEmpty()) {
            if (gouvernorat.isEmpty()) {
                return getEntityManager().createNamedQuery("Publication.findAllAfterId")
                        .setParameter("idDerniere", idDerniere)
                        .setMaxResults(3).getResultList();
            }
            return getEntityManager().createNamedQuery("Publication.findbyGouvernoratAfterId")
                    .setParameter("gouvernorat", gouvernorat)
                    .setParameter("idDerniere", idDerniere)
                    .setMaxResults(3).getResultList();
        }
        if (gouvernorat.isEmpty()) {
            return getEntityManager().createNamedQuery("Publication.findbyCategorieAfterId")
                    .setParameter("categorie", categorie)
                    .setParameter("idDerniere", idDerniere)
                    .setMaxResults(3).getResultList();
        }
        return getEntityManager().createNamedQuery("Publication.findbyCategorieGouvernoratAfterId")
                .setParameter("categorie", categorie)
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
        if (categorie.isEmpty()) {
            if (ville.isEmpty()) {
                return getEntityManager().createNamedQuery("Publication.findAll").setMaxResults(5).getResultList();
            }
            return getEntityManager().createNamedQuery("Publication.findbyVille")
                    .setParameter("ville", ville)
                    .setMaxResults(5).getResultList();
        }
        if (ville.isEmpty()) {
            return getEntityManager().createNamedQuery("Publication.findbyCategorie")
                    .setParameter("categorie", categorie)
                    .setMaxResults(5).getResultList();
        }
        return getEntityManager().createNamedQuery("Publication.findbyCategorieVille")
                .setParameter("categorie", categorie)
                .setParameter("ville", ville)
                .setMaxResults(5).getResultList();
    }

    public List<Publication> ajouterEtablissementPublications(String categorie, String ville, int idDerniere) {
            if (categorie.isEmpty()) {
            if (ville.isEmpty()) {
                return getEntityManager().createNamedQuery("Publication.findAllAfterId")
                        .setParameter("idDerniere", idDerniere)
                        .setMaxResults(3).getResultList();
            }
            return getEntityManager().createNamedQuery("Publication.findbyVilleAfterId")
                    .setParameter("ville", ville)
                    .setParameter("idDerniere", idDerniere)
                    .setMaxResults(3).getResultList();
        }
        if (ville.isEmpty()) {
            return getEntityManager().createNamedQuery("Publication.findbyCategorieAfterId")
                    .setParameter("categorie", categorie)
                    .setParameter("idDerniere", idDerniere)
                    .setMaxResults(3).getResultList();
        }
        return getEntityManager().createNamedQuery("Publication.findbyCategorieVilleAfterId")
                .setParameter("categorie", categorie)
                .setParameter("ville", ville)
                .setParameter("idDerniere", idDerniere)
                .setMaxResults(3).getResultList();    
    }

}
