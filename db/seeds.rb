#!/bin/env ruby
# encoding: utf-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Category.delete_all
Category.create(name: 'Deportes')
Category.create(name: 'Entretención')
Category.create(name: 'Familia')
Category.create(name: 'Computación')
Category.create(name: 'Salud')
Category.create(name: 'Belleza')
Category.create(name: 'Turismo')
Category.create(name: 'Tecnología')
Category.create(name: 'Ciencias')
Category.create(name: 'Música')
Category.create(name: 'Otros')

Denunce.delete_all
Denunce.create(name: 'Inválido',description: 'La URL no existe, o dejo de existir')
Denunce.create(name: 'Phishing',description: 'La URL apunta a un posible sitio de phishing')
Denunce.create(name: 'Virus',description: 'La URL apunta a un sitio con contenido dañino')
Denunce.create(name: 'Inadecuado',description: 'La URL apunta a un sitio de contenidos para adultos')
Denunce.create(name: 'Piratería',description: 'La URL apunta a un sitio que atenta contra derechos de autor')
Denunce.create(name: 'Otro',description: 'La URL se sospecha insegura por otras causas')


