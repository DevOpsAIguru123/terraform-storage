terraform { 
  cloud { 
    
    organization = "devops_vv" 

    workspaces { 
      name = "devops-dev" 
    } 
  } 
}
