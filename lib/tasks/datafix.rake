namespace :werkd do

  task project_creators: :environment do
    class Project < ActiveRecord::Base
      acts_as_taggable
    end
    Project.all.each do |project|
      unless project.creator_collaborator
        collaboration = Collaboration.new
        collaboration.collaborator = project.creator
        collaboration.accepted_at=project.created_at
        collaboration.project = project
        collaboration.save!
        collaboration.skill_list = project.tag_list
      end
    end
  end

  task project_tags: :environment do
    names = %Q/
    Design
Art Direction
Creative Direction
2D Animation
3D Animation
Stop Motion Animation
Traditional Animation
Flash
Composite
Modeling
Rigging
Lighting
Storyboarding
Editing
Production
VFX
Nuke
Flame
Maya
Cinema 4D
AfterEffects
Photoshop
Illustrator
Indesign
FinalCutPro
Technical Direction
CG Supervision
VFX Supervision
Live action Direction
Animation
Motion Graphics
Illustration
Photography
Graphic Design
Soft Image
RealFlow
Executive Production
Interior Design
Decoration
Concept Art
Concept Development
Furniture Design
Space Planning
Retail Design
Residential Design
Textiles
Interior Architecture
Merchandising
Architectural Design
Wardrobe Styling
Hair Styling
Makeup
Editorial
Advertising
Copywriting
Fashion Writing
Photo shoot Direction
Beauty
Publicity
Social Media
Blogging
Trend Analysis
Journalism
Cinematography
Photo Editing
Account supervising
Smoke
Product Management
Digital Strategy
Digital Marketing
UX
UI
Mobile Apps
Mobile Marketing
E-commerce
Content Strategy
Digital Media
Information Architecture
Google Analytics
Responsive design
Web design
Wireframe
Interactive Design
Front end development
Back end development
Business Development
HTML5
CSS3
Sound design
Pro tools
Music production
Film production
Ruby on Rails
Wordpress
Java
JavaScript
JQuery
XML
AJAX
SQL
WML
ActionScript
Avid
C++
PHP
Json
Scrum
MySQL
Mac OSX
MongoDB
C
Node.js
Android Development
APIs
Git
Github
Relational Databases
Unix
Linux
SASS/

    names.split("\n").each do |name|
      Tag.find_or_create_by_name(name) if name.present?
    end
  end
end
