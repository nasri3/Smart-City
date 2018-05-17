/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.DAO;

import com.beans.Etablissement;
import java.util.List;
import javax.ejb.Stateless;
import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

/**
 *
 * @author Wissem
 */
@Stateless
public class EtablissementDAO extends AbstractDAO<Etablissement> {

    @PersistenceContext(unitName = "PCDPU")
    private EntityManager em;

    @Override
    protected EntityManager getEntityManager() {
        return em;
    }

    public EtablissementDAO() {
        super(Etablissement.class);
    }

    public List<Etablissement> findAll() {
        return getEntityManager().createNamedQuery("Etablissement.findAll").getResultList();
    }

    public Etablissement findByNom(String nom) {
        return (Etablissement) getEntityManager().createNamedQuery("Etablissement.findByNom")
                .setParameter("nom", nom)
                .getSingleResult();
    }

}
