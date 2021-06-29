from typing import Text
from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
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

    healthchecks = Custom("healthchecks", "./healthchecksio.png")

    unraid >> rclone >> appdata

    rclone << Edge(color="firebrick", style="dashed") << healthchecks