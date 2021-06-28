from diagrams import Cluster, Diagram
from diagrams.azure.database import BlobStorage
from diagrams.generic.storage import Storage
from diagrams.programming.language import Bash

with Diagram("Homelab Remote Backup", show=False):

    with Cluster("On-Prem"):
        unraid = Storage("unraid-appdata")
        rclone = Bash("rclone")

    with Cluster("Azure"):
        with Cluster("Storage-Account"):
            appdata = BlobStorage("unraid-appdata")

    unraid >> rclone >> appdata