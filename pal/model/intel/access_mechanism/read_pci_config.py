from pal.model.access_mechanism import AbstractAccessMechanism
from dataclasses import dataclass

@dataclass()
class ReadPciConfig(AbstractAccessMechanism):
    """ Access mechanism for reading a value from PCI configuration space using """
    """ the x86 IN instruction over port 0xCF8 and 0xCFC """

    offset: str = ""
    """ The offset into PCIe configuration space """

    name: str = "read_pci_config"
    """ The name of this access mechanism  """

    def is_read(self):
        return True

    def is_write(self):
        return False

    def is_memory_mapped(self):
        return False

    def is_valid(self):
        # TODO: Check if port offset is valid
        return True
